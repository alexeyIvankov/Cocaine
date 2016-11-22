//
//  Service1.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 14.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import Cocaine

protocol IService1 : class,  IDependence
{

}

class Service1 : IService1
{
    public func memoryRules() -> MemoryRules {
        return MemoryRules.singleton
    }
}
