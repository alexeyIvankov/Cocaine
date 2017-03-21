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
    
    var logger: ILogger!
    
    //MARK: Внедряем зависимости
    func identifiersRequiredDependencies() -> [String] {
        return [String(describing: ILogger.self)]
    }
    
    func injectDependences(dependences:[String:AnyObject]) {
        logger = dependences[String(describing: ILogger.self)] as! ILogger
    }
    
    //MARK: Используем зависимости
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logger.log("I'm here!")
    }
}

