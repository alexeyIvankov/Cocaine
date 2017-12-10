//
//  CocaineTests.swift
//  CocaineTests
//
//  Created by Alexey Ivankov on 30.11.2017.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import XCTest
import Cocaine
@testable import Cocaine



class CocaineTests: XCTestCase {
    
    var cocaine:I_Cocaine!
    
    override func setUp() {
        super.setUp()
        
         cocaine = Cocaine()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdd(){
        
//        cocaine.register.register(assembly: Assembly.init(buildType: I_TestService1.self, memoryPolicy: .Strong, instanceScope: .Singleton, buildBlock: { () -> AnyObject in
//            return TestService1()
//        }))
//
//        cocaine.register.register(assembly: Assembly.init(buildType: I_TestService2.self, memoryPolicy: .Strong, instanceScope: .Singleton, buildBlock: { () -> AnyObject in
//            return TestService2()
//        }))
        
        let service1:I_TestService1? = cocaine.injector.inject()
        XCTAssert(service1 != nil)
        
        let service2:I_TestService2? = cocaine.injector.inject()
        XCTAssert(service2 != nil)
        
    }
    
    
    func testSingleton(){
        
//        cocaine.register.register(assembly: Assembly.init(buildType: I_TestService1.self, memoryPolicy: .Strong, instanceScope: .Singleton, buildBlock: { () -> AnyObject in
//            return TestService1()
//        }))
//
//        cocaine.register.register(assembly: Assembly.init(buildType: I_TestService2.self, memoryPolicy: .Strong, instanceScope: .Singleton, buildBlock: { () -> AnyObject in
//            return TestService2()
//        }))
        
        let service1_inject1:TestService1? = cocaine.injector.inject()
        let service2_inject1:TestService2? = cocaine.injector.inject()
        
//        cocaine.register.register(assembly: Assembly.init(buildType: I_TestService1.self, memoryPolicy: .Strong, instanceScope: .Singleton, buildBlock: { () -> AnyObject in
//            return TestService1()
//        }))
//
//        cocaine.register.register(assembly: Assembly.init(buildType: I_TestService2.self, memoryPolicy: .Strong, instanceScope: .Singleton, buildBlock: { () -> AnyObject in
//            return TestService2()
//        }))
        
        
        let service1_inject2:TestService1? = cocaine.injector.inject()
        let service2_inject2:TestService2? = cocaine.injector.inject()
        
        XCTAssertEqual(service1_inject1, service1_inject2)
        XCTAssertEqual(service2_inject1, service2_inject2)
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
