//
//  Cocaine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 27.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public class Cocaine : I_Cocaine, I_Register, I_Injector, I_Tester
{
    lazy public var register:I_Register = self
    lazy public var injector:I_Injector = self
    lazy public var tester:I_Tester = self
    
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
    
    public func register(assembly:I_Assembly){
        
        let buildType:Any = assembly.buildType
        let key:String = String(describing: buildType)
        assemblys[key] = assembly
    }
    
    //MARK: Inject
    
    public func inject<T>() -> T? {
        
        let key = String (describing: T.self)
        var instance = dependence(key: key)
        return instance as? T
    }
    
    public func buildAndInject<T>(memoryPolicy:MemoryPolicy) -> T? {
        
        let key = String (describing: T.self)
        
        guard self.assemblys[key] != nil else {
            return nil
        }
        
        let assembly:I_Assembly = self.assemblys[key]!
        let instance:T?
        
        instance = assembly.build() as? T
        
        guard instance != nil else {
            return nil
        }
        
        let dependence:AnyObject? = instance as AnyObject
        
        guard dependence != nil else {
            return nil
        }
        
      
        if memoryPolicy == .Strong{
            strongDependences.add(object: dependence!, key: key)
        }
        else if memoryPolicy == .Weak{
            weakDependences.add(object: dependence!, key: key)
        }
        
        
        return instance
    }
    
    //MARK: - Test
    
    public func add(test:I_CocaineTest, key:String){
        
    }
    
    public func test(key:String) -> I_CocaineTest?{
        return nil
    }
    
    public func remove(test:I_CocaineTest, key:String){
        
    }
    
    public func removeAllTests(){
        
    }
    
}
