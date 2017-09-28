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


class Application : UIApplication
{
    private(set) var injector:I_Injector!
    private(set) var registrator:I_Registrator!
    private var cocaine:I_Cocaine!
    
    override init() {
        
        super.init()
        buildCocaine()
        loadAssemblys()
        
    }
    
    func buildCocaine(){
        
        self.cocaine = Cocaine()
        self.injector = cocaine
        self.registrator = cocaine
    }
    
    func loadAssemblys()
    {

        self.registrator.prepareToInject(assembly: AssemblyTemplate(buildType: ITestService1.self, scope:.Singleton, isLazy: true, buildBlock: { () -> AnyObject in
            
            return TestService1()
        }))
        
        self.registrator.prepareToInject(assembly: AssemblyTemplate(buildType: ITestService2.self, scope:.Singleton, isLazy: true, buildBlock: { () -> AnyObject in
            
            return TestService2(param1: "1", param2: "2")
        }))
        
    }
}
