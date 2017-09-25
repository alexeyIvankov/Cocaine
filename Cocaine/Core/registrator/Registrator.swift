//
//  Registrator.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 25.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

class Registrator : I_Registrator
{
    let containerManager:I_ContainerManager
    
    required init(containerManager:I_ContainerManager) {
        self.containerManager = containerManager
    }
    
    //MARK: Registrator
    public func register<T: AnyObject>(_ build:()->T, memoryPolicy: DependenceMemoryPolicy = DependenceMemoryPolicy.Strong){
        let instance = build()
        let key = String(describing: instance.self)
        containerManager.load(dependence: instance, key: key, memoryRules: memoryPolicy)
    }
    
    public func register<T: AnyObject>(key:String, _ build:()->T, memoryPolicy: DependenceMemoryPolicy = DependenceMemoryPolicy.Strong){
        let instance = build()
        containerManager.load(dependence: instance, key: key, memoryRules: memoryPolicy)
    }
}
