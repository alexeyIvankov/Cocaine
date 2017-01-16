//
//  Parametrs.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 16.01.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public struct Parametrs
{
    private var parametrs:[String:AnyObject] = [:]
    
    public init()
    {
    
    }
    
    public mutating func set_parametr<T>(name:String, parametr:T){
        self.parametrs[name] = parametr as AnyObject?;
    }
    
    public func get_parametr<T>(name:String) -> T?{
        return self.parametrs[name] as? T;
    }
}
