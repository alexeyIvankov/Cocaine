//
//  ViewController.swift
//  CocaineExample
//
//  Created by Alexey Ivankov on 14.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import UIKit
import Cocaine

class ViewController: UIViewController, IDependenceClient {
    
    
    func injectInteractor(interactor:[String:IDependence])
    {
        print("123");
    }
    
    public func neededDependencesForCreatingInteractor() -> [String] {
        return [String(describing: IService1.self)];
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.injectDependences();
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

