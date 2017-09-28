//
//  Cocaine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 27.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation


public class Cocaine : I_Cocaine
{
    private var assemblys:Dictionary<String, I_Assembly>
    private var dependences:Container<AnyObject>
    
    required public init(){
        
        assemblys = Dictionary<String, I_Assembly>()
        dependences =  Container<AnyObject>(memoryPolicy: Container.MemoryPolicy.Strong)
    }
    
    //Registrator
    
    public func prepareToInject(assembly:I_Assembly){
        
        let buildType:Any = assembly.buildType
        let key:String = String(describing: buildType)
        assemblys[key] = assembly
        
        if assembly.isLazy == false {
            dependences.add(object: assembly.build(), key: String(describing: assembly.buildType))
        }
    }
    
    //MARK: Inject
    
    public func inject<T>() -> T?{
        
        let key = String (describing: T.self)
        return inject(key: key) as? T
    }
    
    public func inject(key:String) -> AnyObject?{
        
        guard self.assemblys[key] != nil else {
            return nil
        }
        
        var instance:AnyObject? = nil
        let assembly:I_Assembly = self.assemblys[key]!
        
        if assembly.scope == .Rebuild {
            
            instance = assembly.build()
            dependences.add(object: instance as AnyObject, key: key)
        }
        else if assembly.scope == .Singleton {
            
            instance = self.dependences.object(key: key)
            
            if instance == nil {
                
                instance = assembly.build()
                dependences.add(object: instance as AnyObject, key: key)
            }
        }
        
        return instance
    }
}
