//
//  Injector.swift
//  DependenceStorage
//
//  Created by Alexey Ivankov on 27.10.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation


open class Injector
{
    fileprivate let storage:DependenceStorage;
    
    public init() {
        storage = DependenceManager();
    }
    
    
    open func inject(client:AnyObject)
    {
    
//        for dependence in self.dependences(client)
//        {
//            client.injectDependence(dependence: dependence);
//        }
    }
    
    
    open func dependence(name:AnyClass) -> IDependence? {
        return self.storage.dependence(name: name);
    }
    
    
    private func dependences(_ dependenceInject:AnyClass) -> Array<IDependence> {
        
        let dependences:Array<IDependence> = Array<IDependence>();
        
//        for name:AnyClass in dependenceInject.requiredDependences()
//        {
//            let dependence:IDependence? = self.dependence(name: name)
//            
//            if dependence != nil{
//                dependences.append(dependence!);
//            }
//        }
        return dependences;
    }
}
