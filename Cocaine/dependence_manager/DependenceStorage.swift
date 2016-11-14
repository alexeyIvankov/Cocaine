//
//  IDependenceStorage.swift
//  DependenceStorageSwift
//
//  Created by Ivankov Alexey on 06.05.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

protocol DependenceStorage
{
	func add(dependence:IDependence);
	
	subscript(name:AnyClass) ->IDependence?{ get set }
	
	func dependence(name:AnyClass) -> IDependence?;
	func allDependences() ->[IDependence];
	
	func removeAll();
	func removeDependence(name:AnyClass);
}
