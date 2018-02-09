//
//  Cocaine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 27.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public protocol AssemblyProvider : AnyObject {
    func assembly() -> I_Assembly?
}

public class Cocaine : I_Cocaine, I_Register, I_Injector
{
    lazy public var register:I_Register = self
    lazy public var injector:I_Injector = self
    
    internal var assemblys:Dictionary<String, I_Assembly>
    internal var strongDependences:Container<AnyObject>
    internal var weakDependences:Container<AnyObject>
    
    internal var assemblyProvier:Container<AnyObject>
    
    required public init(){
        
        assemblys = Dictionary<String, I_Assembly>()
        strongDependences =  Container<AnyObject>(memoryPolicy: Container.MemoryPolicy.Strong)
        weakDependences =  Container<AnyObject>(memoryPolicy: Container.MemoryPolicy.Weak)
        
        assemblyProvier = Container<AnyObject>( memoryPolicy: Container.MemoryPolicy.Strong)
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
    
    public func subscribe(provider:AssemblyProvider,
                   key:String){
        assemblyProvier.add(object: provider, key: key)
    }
    
    public func unsubscribe(key:String){
        assemblyProvier.remove(key: key)
    }
}

//MARK: - Assembly
extension Cocaine{
    
    internal func trySearchAssemblyFromSubscribers(key:String) -> I_Assembly?{
        return (assemblyProvier.object(key: key) as? AssemblyProvider)?.assembly()
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
