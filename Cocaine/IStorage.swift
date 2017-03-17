//
//  IDependenceStorage.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 06.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

protocol IStorage
{
    associatedtype TypeObject:AnyObject;
    
    func add(object:TypeObject, key:String);
    func object(key:String) -> TypeObject?;
    func remove(key:String);
    func all() -> [TypeObject];
}
