//
//  Cocaine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 27.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public protocol CocaineDelegate : AnyObject {
    func assembly(key:String) -> I_Assembly?
}


public class Cocaine : I_Cocaine, I_Register, I_Injector
{
    lazy public var register:I_Register = self
    lazy public var injector:I_Injector = self
    
    internal var assemblys:Dictionary<String, I_Assembly>
    internal var strongDependences:Container<AnyObject>
    internal var weakDependences:Container<AnyObject>
    
    internal var strongObservers:Container<AnyObject>
    internal var weakObservers:Container<AnyObject>
    
    required public init(){
        
        assemblys = Dictionary<String, I_Assembly>()
        strongDependences =  Container<AnyObject>(memoryPolicy: Container.MemoryPolicy.Strong)
        weakDependences =  Container<AnyObject>(memoryPolicy: Container.MemoryPolicy.Weak)
        
        strongObservers = Container<AnyObject>( memoryPolicy: Container.MemoryPolicy.Strong)
        weakObservers = Container<AnyObject>(memoryPolicy:Container.MemoryPolicy.Weak)
    }
    
    //MARK: - Registrator
    
    public func tryRegister(assembly:I_Assembly) throws {
        
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
    
    public func tryInject<T>() -> T? {
        
        let key = String (describing: T.self)
        
        guard let assembly = tryPrepareAssembly(key: key) else {
            return nil
        }
        
        return tryPrepareInstance(assembly: assembly, key: key)
    }
    
    private func tryPrepareInstance<T>(assembly:I_Assembly, key:String)->T?{
        
        var instance:AnyObject?
  
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
    
    private func tryPrepareAssembly(key:String) -> I_Assembly?{
        
        var assembly:I_Assembly? = trySearchRegisterAssembly(key: key)
        
        if assembly == nil{
            assembly = trySearchAssemblyFromSubscribers(key: key)
            
            if assembly != nil {
                
                try? tryRegister(assembly: assembly!)
                assembly = trySearchRegisterAssembly(key: key)
            }
        }
        
        return assembly
    }
    
}

//MARK: - Observers
extension Cocaine{
    
    func subscribe(observer:CocaineDelegate,
                   key:String,
                   memoryPolicy:MemoryPolicy){
        
        if memoryPolicy == .Strong{
            strongObservers.add(object: observer, key: key)
        }
        else if memoryPolicy == .Weak{
            weakObservers.add(object: observer, key: key)
        }
    }
    
    func unsubscribe(observer:CocaineDelegate, key:String){
        strongObservers.remove(key: key)
        weakObservers.remove(key: key)
    }
}

//MARK: - Assembly
extension Cocaine{
    
    internal func trySearchAssemblyFromSubscribers(key:String) -> I_Assembly?{
        var assembly:I_Assembly?
        
        assembly = (strongObservers.object(key: key) as? CocaineDelegate)?.assembly(key: key)
        
        if assembly == nil{
            assembly = (weakObservers.object(key: key) as? CocaineDelegate)?.assembly(key: key)
        }
        return assembly
    }
    
    internal func trySearchRegisterAssembly(key:String) -> I_Assembly?{
        return self.assemblys[key]
    }
    
}

//MARK: - Dependence
extension Cocaine{
    
    internal func dependence(key:String) -> AnyObject?
    {
        var instance:AnyObject? =  strongDependences.object(key: key)
        
        if instance == nil{
            instance = weakDependences.object(key: key)
        }
        
        return instance
    }
    
    internal func load(instance:AnyObject, key:String, memoryPolicy:MemoryPolicy){
        
        if  memoryPolicy == .Strong {
            strongDependences.add(object: instance, key: key)
        }
        else if memoryPolicy == .Weak {
            weakDependences.add(object: instance, key: key)
        }
        
    }
}
