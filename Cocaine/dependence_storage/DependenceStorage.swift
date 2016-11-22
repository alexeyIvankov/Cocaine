//
//  DependenceStorage.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 10.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

class DependenceStorage: ContainerDependence
{
    
    fileprivate var tables:[MemoryRules:MapTableDependence] =
        
        [MemoryRules.weak:MapTableDependence(memoryRules: MemoryRules.weak),
         MemoryRules.strong:MapTableDependence(memoryRules: MemoryRules.strong),
         MemoryRules.copy:MapTableDependence(memoryRules: MemoryRules.copy),
         MemoryRules.singleton:MapTableDependence(memoryRules: MemoryRules.singleton)]
   
    
	init(){
        
	}
		
	
	//MARK: ContainerDependence
	subscript(name:String) ->IDependence?
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

	internal func add(dependence: IDependence){
        self.tables[dependence.memoryRules()]?.add(dependence: dependence);
	}
    
	
	internal func dependence(name: String) -> IDependence? {
		
		var dependence:IDependence? = nil;
        
        for (_, table) in self.tables
        {
            if dependence != nil && table.dependence(name: name) != nil{
                print("dependence not unique!!!")
                dependence = nil;
                break;
            }
            
            dependence =  table.dependence(name: name);
        }
        
		return dependence;
	}
	
	internal func allDependences() -> [IDependence]
	{
		var dependences:[IDependence] = [];
        
        for (_, table) in self.tables{
           dependences += table.allDependences();
        }
        
		return dependences;
	}
	
	internal func removeDependence(name: String)
	{
		for (_, table) in self.tables{
			table.removeDependence(name: name);
		}
	}
	
 	internal func removeAll()
	{
        for (_, table) in self.tables{
            table.removeAll()
        }
	}
}
