//
//  CocaineEngineTest.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 23.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import XCTest
@testable import Cocaine

class DependenceClientTest : IDependenceClient
{
    public let key:String;
    private(set) var dependence:AnyObject?;
    
    init(key:String){
        self.key = key;
    }
    
    //MARK: IDependenceClient
    func identifiersRequiredDependencies() -> [String] {
        return [self.key];
    }
    
    func injectDependences(dependences:[String:AnyObject]){
        self.dependence = dependences[key];
    }
}

class CocaineEngineTest: XCTestCase {
    
    private var cocaineEngine:CocaineEngine!;
    
    override func setUp() {
        super.setUp()
        
        self.cocaineEngine = CocaineEngine();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample()
    {
        let dependence:NSObject = NSObject();
        let key = "key";
        
        self.cocaineEngine.load(dependence: dependence, key: key, memoryRules: DependenceMemoryPolicy.Strong)
        
        XCTAssertNotNil(self.cocaineEngine.dependence(key: key));
        
        
        let dependenceClient:DependenceClientTest = DependenceClientTest(key: key);
        self.cocaineEngine.inject(client: dependenceClient)
        
        XCTAssertNotNil(dependenceClient.dependence);
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
