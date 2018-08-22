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
    
    func subscribe(provider:AssemblyProvider,
                          key:Any);
    
    func unsubscribe(key:Any)
}

public protocol AssemblyProvider : AnyObject {
    
    func assembly() -> I_Assembly?
    static func buildType()->Any
}

public protocol I_Injector {
 
    func tryInject<T>() -> T?
}

public protocol I_Register{
    
    func tryRegister(assembly:I_Assembly) throws
}


