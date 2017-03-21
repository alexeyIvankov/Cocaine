//
//  DependenceCore.swift
//  MultiBank
//
//  Created by Alexey Ivankov on 18.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import Cocaine

public let cocaineEngine = CocaineEngine();

public func injectClient(client:IDependenceClient){
    cocaineEngine.inject(client: client);
}

public func loadDependence(dependence:AnyObject, key:String, memoryPolicy:DependenceMemoryPolicy){
    cocaineEngine.load(dependence: dependence, key: key, memoryRules: memoryPolicy);
}

public func getDependence(key:String) -> AnyObject?{
    return cocaineEngine.dependence(key: key);
}
