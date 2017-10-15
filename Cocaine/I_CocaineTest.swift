//
//  I_ForwardInject.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 29.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public protocol I_CocaineTest {
    
    func handle(register:@escaping (_ assembly:I_Assembly?) -> Void)
    func handle(inject:@escaping (_ instance:AnyObject?, _ receiver:Any) -> Void)
    func handle(build:@escaping (_ instance:AnyObject?, _ receiver:Any) -> Void)
    
    func mock(register:@escaping (_ assembly:I_Assembly?) -> I_Assembly?)
    func mock(inject:@escaping (_ instance:AnyObject?, _ receiver:Any) -> AnyObject?)
    func mock(build:@escaping (_ receiver:Any) -> AnyObject?)
}
