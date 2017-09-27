//
//  I_Assembly.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 25.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public protocol I_Assembly  : class  {

    var buildType:AnyClass { get }
    var scope:DependenceScope { get }
    var isLazy:Bool { get }
    
    func build() -> AnyObject
}

