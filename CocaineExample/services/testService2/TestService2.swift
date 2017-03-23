//
//  TestService2.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 22.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation


public class TestService2 : ITestService2
{
    public var param1:String
    public var param2:String

    required public init(param1:String, param2:String)
    {
        self.param1 = param1;
        self.param2 = param2;
    }
    
}
