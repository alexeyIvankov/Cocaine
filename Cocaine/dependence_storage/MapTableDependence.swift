//
//  DependenceStorage.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 07.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

class MapTableDependence : ContainerDependence
{
	
	fileprivate var memoryRulesStorage:MemoryRules;
	fileprivate let storage:NSMapTable<NSString,IDependence>;
	fileprivate let capacity:Int = 100;
    fileprivate let lock:NSRecursiveLock
	
	init(memoryRules:MemoryRules)
	{
		memoryRulesStorage = memoryRules;
        storage = NSMapTable<NSString,IDependence>(keyOptions:NSPointerFunctions.Options.copyIn, valueOptions:MapTableDependence.pointerFunctionsOptions(memoryRules));
        lock = NSRecursiveLock();
	}
    
    private static func pointerFunctionsOptions(_ memoryRules:MemoryRules) ->NSPointerFunctions.Options
    {
        var pointerFunctionsOptions:NSPointerFunctions.Options? = nil;
        
        switch(memoryRules)
        {
            case .strong:
                pointerFunctionsOptions = NSPointerFunctions.Options.strongMemory;
            
            case .weak:
                pointerFunctionsOptions = NSPointerFunctions.Options.weakMemory;
            
            case .singleton:
                pointerFunctionsOptions = NSPointerFunctions.Options.strongMemory;
            
            case .copy:
                pointerFunctionsOptions = NSPointerFunctions.Options.copyIn;
        }
        
        return pointerFunctionsOptions!;
    }

	//MARK: ContainerDependence
	internal subscript(name:String) ->IDependence?
    {
		get
        {
            return self.dependence(name: name);
        }
		set
        {
			if (newValue != nil)
			{
				self.add(dependence: newValue!);
			}
			else
			{
				self.removeDependence(name: name);
			}
		}
	}

	func add(dependence: IDependence) {
		
        self.operation {
            self.storage.setObject(dependence, forKey: NSString(string:dependence.key()));
        }
	}
	
	func dependence(name: String) -> IDependence? {
		
		var dependence:IDependence? = nil;
        
        self.operation {
            dependence = self.storage.object(forKey: NSString(string:name)) as IDependence?
        }
		
		return dependence;
	}
	
	func allDependences() -> [IDependence] {
		
		var dependences:[IDependence] = [];
		
        self.operation {
            
            while  let key:NSString = self.storage.keyEnumerator().nextObject() as! NSString?
            {
                let dependence  = self.storage.object(forKey: NSString(string:key)) as IDependence!
                dependences.append(dependence!);
            }
        }
        
		return dependences;
	}
	
	func removeDependence(name: String)
	{
        self.operation
        {
            self.storage.removeObject(forKey: NSString(string:name));
        }
        
	}
	
	func removeAll()
	{
        self.operation {
            self.storage.removeAllObjects();
        }
	}
    
    func operation(block:()->Void)
    {
        self.lock.lock();
            block();
        self.lock.unlock();
    }
}


