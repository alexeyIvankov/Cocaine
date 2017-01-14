//
//  DependenceStorage.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 10.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

class Storage<T:AnyObject>: IStorage
{
    private var storage:[String:T];
    fileprivate let lock:NSRecursiveLock
    
    typealias TypeObject = T
    
    required init()
    {
        storage = [:]
        lock = NSRecursiveLock();
    }
    
    
    //MARK: IDependenceStorage
    
    func add(object:T, key:String)
    {
        self.thread_save_operation { 
            self.storage[key] = object;
        }
    }
    
    func object(key:String) -> T? {
        
        var object:T? = nil;
        
        self.thread_save_operation { 
            object = self.storage[key]
        }
        
        return object;
    }
    
    func remove(key:String)
    {
        self.thread_save_operation { 
             self.storage.removeValue(forKey: key)
        }
    }
    
    func all() -> [T]
    {
        var all_objects:[T] = [];
        
        self.thread_save_operation
        {
            for (_, value) in  self.storage
            {
                all_objects.append(value);
            }
        }
        
        return all_objects;
    }
    
    func thread_save_operation(block:()->Void)
    {
        self.lock.lock();
        block();
        self.lock.unlock();
    }
}

