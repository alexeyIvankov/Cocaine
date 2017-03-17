//
//  DependenceStorage.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 10.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

public enum StorageMemoryPolicy
{
    case Weak
    case Strong
}

class Storage<T:AnyObject>: IStorage
{
    private var storage:NSMapTable<NSString, T>!
    fileprivate let lock:NSRecursiveLock
    
    typealias TypeObject = T
    
    required init(memoryPolicy:StorageMemoryPolicy)
    {
        lock = NSRecursiveLock();
        
        if memoryPolicy == StorageMemoryPolicy.Strong
        {
            storage = NSMapTable(keyOptions: NSPointerFunctions.Options.copyIn, valueOptions: NSPointerFunctions.Options.strongMemory)
        }
        else if memoryPolicy == StorageMemoryPolicy.Weak
        {
            storage = NSMapTable(keyOptions: NSPointerFunctions.Options.copyIn, valueOptions: NSPointerFunctions.Options.weakMemory)
        }
    }
    
    
    //MARK: IDependenceStorage
    
    func add(object:T, key:String)
    {
        self.threadSaveOperation {
            self.storage.setObject(object, forKey: NSString(string:key));
        }
    }
    
    func object(key:String) -> T? {
        
        var object:T? = nil;
        
        self.threadSaveOperation {
            object = self.storage.object(forKey: NSString(string:key))
        }
        
        return object;
    }
    
    func remove(key:String)
    {
        self.threadSaveOperation {
            self.storage.removeObject(forKey:  NSString(string:key))
        }
    }
    
    func all() -> [T]
    {
        var all_objects:[T] = [];
        
        self.threadSaveOperation
        {
            let object_enumerator = self.storage.objectEnumerator()
            
            while let object = object_enumerator?.nextObject()
            {
                if object is T {
                    all_objects.append(object as! T);
                }
            }
        }
        
        return all_objects;
    }
    
    func threadSaveOperation(block:()->Void)
    {
        self.lock.lock();
            block();
        self.lock.unlock();
    }
}

