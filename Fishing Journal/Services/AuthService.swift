//
//  AuthService.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 14.05.24.
//

import Foundation
import Observation
import Supabase

@MainActor
@Observable
final class AuthService {

    var userSession: Auth.User?

    private let client: SupabaseClient
    private let anonKey: String

    init() {
        let config = Self.loadConfig()
        let supabaseURL = config.url
        let supabaseAnonKey = config.anonKey
        self.anonKey = supabaseAnonKey

        self.client = SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: supabaseAnonKey,
            options: .init(
                auth: .init(emitLocalSessionAsInitialSession: true)
            )
        )

        self.userSession = client.auth.currentUser
    }

    func login(withEmail email: String, password: String) async throws {
        guard !anonKey.isEmpty, anonKey != "YOUR_SUPABASE_ANON_KEY" else {
            throw AuthError.missingSupabaseConfig
        }

        do {
            let response = try await client.auth.signIn(
                email: email,
                password: password
            )
            userSession = response.user
        } catch {
            throw AuthError.from(error)
        }
    }

    func createUser(email: String, password: String) async throws {
        guard !anonKey.isEmpty, anonKey != "YOUR_SUPABASE_ANON_KEY" else {
            throw AuthError.missingSupabaseConfig
        }

        do {
            let response = try await client.auth.signUp(
                email: email,
                password: password
            )
            if response.session == nil {
                throw AuthError.requiresEmailConfirmation
            }
            userSession = response.user
        } catch {
            throw AuthError.from(error)
        }
    }

    func signOut() {
        Task {
            try? await client.auth.signOut()
        }
        userSession = nil
    }

    private static func loadConfig() -> SupabaseConfig {
        if
            let path = Bundle.main.path(forResource: "SupabaseConfig", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any],
            let urlString = dictionary["url"] as? String,
            let anonKey = dictionary["anonKey"] as? String,
            let url = URL(string: urlString),
            !anonKey.isEmpty
        {
            return SupabaseConfig(url: url, anonKey: anonKey)
        }

        if
            let urlString = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
            let anonKey = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_ANON_KEY") as? String,
            let url = URL(string: urlString),
            !anonKey.isEmpty
        {
            return SupabaseConfig(url: url, anonKey: anonKey)
        }

        fatalError("Missing Supabase config. Add SupabaseConfig.plist with keys 'url' and 'anonKey', or set SUPABASE_URL/SUPABASE_ANON_KEY in Info.plist.")
    }
}

private struct SupabaseConfig {
    let url: URL
    let anonKey: String
}

enum AuthError: LocalizedError {
    case missingSupabaseConfig
    case requiresEmailConfirmation
    case invalidCredentials
    case rateLimited
    case network
    case generic(String)

    static func from(_ error: Error) -> AuthError {
        if let authError = error as? AuthError {
            return authError
        }

        let message = (error as NSError).localizedDescription
        let lowercase = message.lowercased()

        if lowercase.contains("email rate limit exceeded")
            || lowercase.contains("rate limit")
            || lowercase.contains("too many requests") {
            return .rateLimited
        }

        if lowercase.contains("invalid login credentials")
            || lowercase.contains("invalid email or password")
            || lowercase.contains("email not confirmed") {
            return .invalidCredentials
        }

        if lowercase.contains("network")
            || lowercase.contains("connection refused")
            || lowercase.contains("timed out")
            || lowercase.contains("offline")
            || lowercase.contains("could not connect") {
            return .network
        }

        return .generic(message)
    }

    var errorDescription: String? {
        switch self {
        case .missingSupabaseConfig:
            return "Supabase config is missing. Set project URL and anon key in AuthService."
        case .requiresEmailConfirmation:
            return "Регистрация выполнена. Подтвердите email, затем войдите в аккаунт."
        case .invalidCredentials:
            return "Неверный email или пароль."
        case .rateLimited:
            return "Слишком много запросов. Попробуйте снова чуть позже."
        case .network:
            return "Проблема с сетью. Проверьте интернет и повторите попытку."
        case .generic(let message):
            return message
        }
    }
}
