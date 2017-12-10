//
//  TestService1.swift
//  CocaineTests
//
//  Created by Alexey Ivankov on 30.11.2017.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

protocol I_TestService1 : class  {
    
}

class TestService1 : I_TestService1, Equatable
{
    static func ==(lhs: TestService1, rhs: TestService1) -> Bool {
        return lhs == rhs
    }
    

}
