//
//  Cocaine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 27.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public class Cocaine : I_Cocaine, I_Register, I_Injector
{
    lazy public var register:I_Register = self
    lazy public var injector:I_Injector = self
    
    private var assemblys:Dictionary<String, I_Assembly>
    private var strongDependences:Container<AnyObject>
    private var weakDependences:Container<AnyObject>
    

    required public init(){
        
        assemblys = Dictionary<String, I_Assembly>()
        strongDependences =  Container<AnyObject>(memoryPolicy: Container.MemoryPolicy.Strong)
        weakDependences =  Container<AnyObject>(memoryPolicy: Container.MemoryPolicy.Weak)
    }
    
    private func dependence(key:String) -> AnyObject?
    {
        var instance:AnyObject? =  strongDependences.object(key: key)
        
        if instance == nil{
            instance = weakDependences.object(key: key)
        }
        
        return instance
    }
    
    //MARK: - Registrator
    
    public func register(assembly:I_Assembly) throws {
        
        let buildType:Any = assembly.buildType
        let key:String = String(describing: buildType)
        
        let currentAssembly = assemblys[key]
        
        if currentAssembly != nil{
            
            if currentAssembly!.instanceScope == .Singleton {
                throw CocaineErrors.SingletonRegistered
            }
        }
        
        assemblys[key] = assembly
    }
    
    //MARK: Inject
    
    public func inject<T>() -> T? {
        
        var instance:AnyObject?
        let key = String (describing: T.self)
        
        guard self.assemblys[key] != nil else {
            return nil
        }
        
        let assembly:I_Assembly = self.assemblys[key]!
        
        if assembly.instanceScope == .New {
            instance = assembly.build(injector:self)
        }
        else if assembly.instanceScope == .Singleton {
            
            instance = dependence(key: key)
            
            if instance == nil {
                instance = assembly.build(injector:self)
            }
            
            load(instance: instance!, key: key, memoryPolicy: assembly.memoryPolicy)
        }
        
        return instance as? T
    }
    
    private func load(instance:AnyObject, key:String, memoryPolicy:MemoryPolicy){
        
        if  memoryPolicy == .Strong {
            strongDependences.add(object: instance, key: key)
        }
        else if memoryPolicy == .Weak {
            weakDependences.add(object: instance, key: key)
        }
        
    }
    
    
}
