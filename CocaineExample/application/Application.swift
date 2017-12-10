//
//  Application.swift
//  CocaineExample
//
//  Created by Alexey Ivankov on 28.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit
import Cocaine

class Application : UIApplication, I_Application
{
    private(set) var cocaine:I_Cocaine!
    
    override init() {
        
        super.init()
        buildCocaine()
        loadAssemblys()
        
    }
    
    func buildCocaine(){
        
        self.cocaine = Cocaine()
    }
    
    func loadAssemblys()
    {
         do
         {
            try self.cocaine.register.register(assembly: Assembly(buildType: ITestService1.self, memoryPolicy: .Strong, instanceScope: .Singleton, buildBlock: { () -> AnyObject in
                
                return TestService1()
            }))
            
            
         } catch
         {
            
        }
        
        
        
        try? self.cocaine.register.register(assembly: Assembly(buildType: ITestService1.self, memoryPolicy: .Strong, instanceScope: .Singleton, buildBlock: { () -> AnyObject in
            
            return TestService1()
        }))
        
        try? self.cocaine.register.register(assembly: Assembly(buildType: ITestService2.self, memoryPolicy: .Strong, instanceScope: .Singleton, buildBlock: { () -> AnyObject in
            
            return TestService2(param1: "1", param2: "2")
        }))
        
    }
}
