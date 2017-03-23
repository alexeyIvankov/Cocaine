//
//  ViewController.swift
//  CocaineExample
//
//  Created by Alexey Ivankov on 14.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import UIKit
import Cocaine

class ViewController: UIViewController, IDependenceClient
{
    weak var service1:ITestService1?;
    weak var service2:ITestService2?;
   
    public func injectDependences(dependences: [String : AnyObject])
    {
        self.service1 = dependences[String(describing: ITestService1.self)] as? ITestService1;
        self.service2 = dependences[String(describing: ITestService2.self)] as? ITestService2;
    }

    public func identifiersRequiredDependencies() -> [String] {
        return [String(describing: ITestService1.self), String(describing: ITestService2.self)];
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        injectClient(dependenceClient: self);
    
        print(self.service1);
        print(self.service2)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

