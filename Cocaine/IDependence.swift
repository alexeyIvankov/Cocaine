//
//  IDependence.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 06.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

@objc public enum MemoryRules: Int
{
	case strong
	case weak
	case copy
	case singleton
}

@objc public protocol IDependence: class, AnyObject
{
	func memoryRules() -> MemoryRules;
}

internal extension IDependence
{
    func key() -> String{
        return String(describing: type(of:self))
    }
}
