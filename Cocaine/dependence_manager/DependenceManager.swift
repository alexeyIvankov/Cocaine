//
//  DependenceStorage.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 10.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

class DependenceManager: DependenceStorage
{
	fileprivate lazy var dependenceStorageWeak:DependenceStorage = {
        return DependenceStorageMemoryRules(memoryRules: MemoryRules.weak) }()
    
	fileprivate lazy var dependenceStorageStrong:DependenceStorage = {
        return DependenceStorageMemoryRules(memoryRules: MemoryRules.strong) }()
    
	fileprivate lazy var dependenceStorageCopy:DependenceStorage = {
        return  DependenceStorageMemoryRules(memoryRules: MemoryRules.copy) }()
    
	fileprivate lazy var dependenceStorageSingleton:DependenceStorage = {
        return DependenceStorageMemoryRules(memoryRules: MemoryRules.singleton) }()
	
	fileprivate lazy var containerStorages:[DependenceStorage] = {
        return [self.dependenceStorageWeak, self.dependenceStorageStrong, self.dependenceStorageCopy, self.dependenceStorageSingleton] }();
	
	init()
	{
	
	}
	
	fileprivate func dependenceStorage(_ memoryRules:MemoryRules) -> DependenceStorage
	{
		switch(memoryRules)
		{
			case .copy:
				return self.dependenceStorageCopy;
			
			case .weak:
				return self.dependenceStorageWeak;
			
			case .strong:
				return self.dependenceStorageStrong;
			
			case .singleton:
				return self.dependenceStorageSingleton;
		}
	}
	
	
	//MARK: IDependenceStorage
	subscript(name:AnyClass) ->IDependence?
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

	internal func add(dependence: IDependence) {
		self.dependenceStorage(dependence.memoryRules()).add(dependence: dependence);
	}
    
	
	internal func dependence(name: AnyClass) -> IDependence? {
		
		var dependence:IDependence? = nil;
		
		for dependenceStorage:DependenceStorage in self.containerStorages
		{
			dependence = dependenceStorage.dependence(name:name);
			
            if (dependence != nil){
				break;
			}
		}
		
		return dependence;
	}
	
	internal func allDependences() -> [IDependence]
	{
		var dependences:[IDependence] = [];
		
		for dependenceStorage:DependenceStorage in self.containerStorages
		{
			dependences += dependenceStorage.allDependences();
		}
		
		return dependences;
	}
	
	internal func removeDependence(name: AnyClass)
	{
		for dependenceStorage:DependenceStorage in self.containerStorages
		{
			dependenceStorage.removeDependence(name: name);
		}
	}
	
 	internal func removeAll()
	{
		self.dependenceStorageCopy.removeAll();
		self.dependenceStorageSingleton.removeAll();
		self.dependenceStorageWeak.removeAll();
		self.dependenceStorageStrong.removeAll();
	}
}
