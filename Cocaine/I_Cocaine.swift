//
//  I_Cocaine.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 27.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public protocol I_Cocaine  {

    var register:I_Register { get }
    var injector:I_Injector { get }
    var tester:I_Tester { get }
    
}

public protocol I_Injector {
 
    func inject<T>() -> T?
    func buildAndInject<T>(memoryPolicy:MemoryPolicy) -> T?
}

public protocol I_Register{
    
    func register(assembly:I_Assembly)
}

public protocol I_Tester {
    
    func add(test:I_CocaineTest, key:String)
    func test(key:String) -> I_CocaineTest?
    func remove(test:I_CocaineTest, key:String)
    func removeAllTests()
}
