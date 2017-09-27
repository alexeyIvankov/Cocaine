//
//  I_Injector.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 27.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public protocol I_Injector{
    
    func inject<T>() -> T!
    func inject(key:String) -> AnyObject?
    
}
