//
//  IDependenceStorage.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 06.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

protocol ContainerDependence
{
	func add(dependence:IDependence);
	
	subscript(name:String) ->IDependence?{ get set }
	
	func dependence(name:String) -> IDependence?;
	func allDependences() ->[IDependence];
	
	func removeAll();
	func removeDependence(name:String);
}
