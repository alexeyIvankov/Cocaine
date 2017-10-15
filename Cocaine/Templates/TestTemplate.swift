//
//  TestTemplate.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 16.10.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

class TestTemplate : I_CocaineTest{
    
    private(set) var registerHandler:((_ assembly:I_Assembly?) -> Void)?
    private(set) var buildHandler:((_ instance:AnyObject?, _ receiver:Any) -> Void)?
    private(set) var injectHandler:((_ instance:AnyObject?, _ receiver:Any) -> Void)?
    
    private(set) var registerMoc:((_ assembly:I_Assembly?) -> I_Assembly?)?
    private(set) var buildMoc:((_ receiver:Any) -> AnyObject?)?
    private(set) var injectMoc:((_ instance:AnyObject?, _ receiver:Any) -> AnyObject?)?
    
    
    public func handle(register:@escaping (_ assembly:I_Assembly?) -> Void){
        self.registerHandler = register
    }
    
    public func handle(inject:@escaping (_ instance: AnyObject?, _ receiver:Any) -> Void){
        self.injectHandler = inject
    }
    
    public func handle(build:@escaping (_ instance: AnyObject?, _ receiver:Any) -> Void){
        self.buildHandler = build
    }
    
    public func mock(register: @escaping (I_Assembly?) -> I_Assembly?) {
        self.registerMoc = register
    }
    
    public func mock(inject: @escaping (AnyObject?, Any) -> AnyObject?) {
        self.injectMoc = inject
    }
    
    public func mock(build: @escaping (Any) -> AnyObject?) {
        self.buildMoc = build
    }
    
}
