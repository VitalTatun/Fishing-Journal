//
//  Mockable.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 15.11.24.
//

import Foundation

public protocol Mockable {
    associatedtype MockType
    
    static var mock: MockType { get }
    static var mockList: [MockType] { get }
}

public extension Mockable {
    static var mock: MockType {
        mockList[1]
    }
    
    static var mockList:  [MockType] {
        []
    }
}
