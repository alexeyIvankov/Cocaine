//
//  DependenceCore.swift
//  Cocaine
//
//  Created by Nikita on 27.07.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public class Cocaine : CocaineDirector,  Registrator, Injector
{
    lazy var registrator: Registrator = self
    lazy var injector: Injector = self
    
    private lazy var containerManager = ContainersManager();
    
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
    
    //MARK: Injector
    public func inject<T>() -> T! {
        let key = String(describing: T.self)
        return containerManager.dependence(key: key) as? T
    }
    
    public func inject(key:String) -> AnyObject? {
        return containerManager.dependence(key: key)
    }
}
