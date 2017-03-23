//
//  StorageTest.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 22.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import XCTest
@testable import Cocaine

class StorageTest: XCTestCase {
    
    var storage:Storage<AnyObject>?;
    
    
    override func setUp()
    {
        super.setUp()
        
        self.storage = Storage(memoryPolicy: StorageMemoryPolicy.Strong);
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample()
    {
        self.testAdd();
        self.testRead();
        self.testRemove();
        self.testMultiThreading()
    }
    
    func testAdd()
    {
        for  index in 0..<100
        {
            let obj:NSObject = NSObject();
            self.storage?.add(object: obj, key: String(index));
        }
        
        XCTAssert(self.storage?.all().count == 100);
    }
    
    
    func testRemove()
    {
        guard self.storage != nil, self.storage!.all().count != 0 else {
            return;
        }
        
        let count:Int = (self.storage?.all().count)!
        
        for  index in 0..<count
        {
            self.storage?.remove(key: String(index));
        }
        
        
        XCTAssert(self.storage?.all().count == 0);
    }
    
    func testRead()
    {
        guard self.storage != nil, self.storage!.all().count != 0 else {
            return;
        }
        
        
        let count:Int = (self.storage?.all().count)!
        
        for  index in 0..<count
        {
            XCTAssertNotNil(self.storage?.object(key: String(index)));
        }
    }
    
    func testMultiThreading()
    {
        DispatchQueue.global(qos: .background).async
        {
            for  index in 0..<100
            {
                let obj:NSObject = NSObject();
                self.storage?.add(object: obj, key: String(index));
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async
        {
            for  index in 0..<100
            {
                self.storage?.remove(key: String(index));
            }
        }
        
        DispatchQueue.main.async
        {
            for  index in 0..<100
            {
                self.storage?.remove(key: String(index));
            }
        }
        
        DispatchQueue(label: "test").async
        {
            for  index in 0..<100
            {
                let _ = self.storage?.object(key: String(index));
            }
        }
        
    }
 

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
