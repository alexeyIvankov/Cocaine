//
//  Service2DependenceBuilder.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 22.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import Cocaine

class Service2DependenceBuilder : IDependenceBuilder
{
   
    public var param1:String
    public var param2:String
    
    required public init(param1:String, param2:String)
    {
        self.param1 = param1;
        self.param2 = param2;
    }
    
    func buildAndLoad()
    {
        let testService2 = TestService2(param1: self.param1, param2: self.param2)
        loadDependence(dependence: testService2, key: String(describing: ITestService2.self), memoryRules: DependenceMemoryPolicy.Strong)
    }
}
