//
//  DependenceEngine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 18.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

public class CocaineEngine
{
    private let storageStrongRef:Storage<AnyObject>
    private let storageWeakRef:Storage<AnyObject>
   
    public required init()
    {
        self.storageStrongRef = Storage<AnyObject>(memoryPolicy: StorageMemoryPolicy.Strong);
        self.storageWeakRef = Storage<AnyObject>(memoryPolicy: StorageMemoryPolicy.Weak);
    }
    
    public func inject(client:IDependenceClient)
    {
        var dependences:[String:AnyObject] = [:]
        
        let identifiersRequiredDependencies = client.identifiersRequiredDependencies()
        
        for identifier in identifiersRequiredDependencies
        {
            let dependence:AnyObject? = self.dependence(key: identifier);
            
            if dependence != nil{
                dependences[identifier] = dependence;
            }
        }
        client.injectDependences(dependences: dependences);
    }
    
    public func load(dependence:AnyObject, key:String, memoryRules:DependenceMemoryPolicy) {
        
        if memoryRules == DependenceMemoryPolicy.Strong {
            self.storageStrongRef.add(object: dependence, key: key)
        }
        else if memoryRules == DependenceMemoryPolicy.Weak {
             self.storageWeakRef.add(object: dependence, key: key)
        }
    }
    
    public func dependence(key:String) -> AnyObject?
    {
        var dependence:AnyObject?;
        
        dependence = self.storageStrongRef.object(key: key);
        
        if dependence == nil{
            dependence = self.storageWeakRef.object(key: key);
        }
        
        return dependence;
    }
    
}
