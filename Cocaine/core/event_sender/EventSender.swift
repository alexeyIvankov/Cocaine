//
//  EventSender.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 18.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

class EventSender<T>  {
    
    typealias T = AnyObject
    
    fileprivate let subscribers:NSMapTable<NSString,T>;
    fileprivate let lock:NSRecursiveLock
    
    init()
    {
        subscribers = NSMapTable<NSString,T>(keyOptions:NSPointerFunctions.Options.copyIn, valueOptions:NSPointerFunctions.Options.strongMemory);
        lock = NSRecursiveLock();
    }
    
    
    func subscribe(subscriber: T, typeEvent:String)
    {
        self.operation
        {
            var container:NSHashTable<T>? = self.subscribers.object(forKey: NSString(string:typeEvent)) as! NSHashTable<T>?
            
            if container == nil
            {
                container = self.createWeakContainer();
                self.subscribers.setObject(container, forKey: NSString(string:typeEvent));
            }
            container?.add(subscriber)
        }
    }
    
    func unsubscribe(subscriber: T, typeEvent:String)
    {
        self.operation
        {
            let container:NSHashTable<T>? = self.subscribers.object(forKey: NSString(string:typeEvent)) as! NSHashTable<EventSender.T>?;
            container?.remove(subscriber);
        }
    }
    
    func subscribers(typeEvent:String) -> [T]?
    {
        var subscribers:[T]  = [];
        
        self.operation
        {
            let container:NSHashTable<T>? = self.subscribers.object(forKey: NSString(string:typeEvent)) as! NSHashTable<EventSender.T>?;
            
            if container != nil
            {
                for item in container!.allObjects {
                    subscribers.append(item);
                }
            }

        }
        
        return subscribers;
    }
    
    
    fileprivate func operation(block:()->Void)
    {
        self.lock.lock();
        block();
        self.lock.unlock();
    }
    
    fileprivate func createWeakContainer<T>() -> NSHashTable<T> {
        return NSHashTable(options: NSPointerFunctions.Options.weakMemory);
    }
}
