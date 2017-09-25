//
//  IContainerManager.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 25.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public protocol I_ContainerManager {
    
    func load(dependence:AnyObject, key:String, memoryRules:DependenceMemoryPolicy)
    func dependence(key:String, memoryPolicy:DependenceMemoryPolicy) -> AnyObject?
    
}
