//
//  ViewController.swift
//  CocaineExample
//
//  Created by Alexey Ivankov on 14.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import UIKit
import Cocaine

class ViewController: UIViewController
{
    weak var service1:ITestService1? = tryInject()
    weak var service2:ITestService2? = tryInject()
   

    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        print(self.service1);
        print(self.service2)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

