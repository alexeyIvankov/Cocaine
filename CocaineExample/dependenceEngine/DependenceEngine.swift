//
//  DependenceEngine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 22.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import Cocaine

private let dependenceEngine:CocaineEngine = CocaineEngine();

public func injectClient(dependenceClient:IDependenceClient){
    dependenceEngine.inject(client: dependenceClient);
}

public func loadDependence(dependence:AnyObject, key:String, memoryRules: DependenceMemoryPolicy){
    dependenceEngine.load(dependence: dependence, key: key, memoryRules: memoryRules);
}

public func dependence(key:String) -> AnyObject?{
    return dependenceEngine.dependence(key: key);
}
