//
//  TestDependenceProvider.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 22.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import Cocaine

class TestDependenceProvider : IDependenceProvider
{
    static func loadDependences()
    {
        let service1:ITestService1 = TestService1();
        
        loadDependence(dependence: service1, key: String(describing: ITestService1.self), memoryRules: DependenceMemoryPolicy.Strong);

    }
}
