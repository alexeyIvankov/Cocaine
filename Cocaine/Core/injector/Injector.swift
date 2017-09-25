//
//  Injector.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 25.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

class Injector : I_Injector
{
    let containerManager:I_ContainerManager
    
    required init(containerManager:I_ContainerManager) {
        self.containerManager = containerManager
    }
    
    //MARK: Injector
    public func inject<T>(memoryPolicy: DependenceMemoryPolicy ) -> T! {
        let key = String(describing: T.self)
        return containerManager.dependence(key: key, memoryPolicy: memoryPolicy) as? T
    }
    
    public func inject(key:String, memoryPolicy: DependenceMemoryPolicy ) -> AnyObject? {
        return containerManager.dependence(key: key, memoryPolicy: memoryPolicy)
    }
}
