//
//  NavigationController.swift
//  Cocaine
//
//  Created by Evgeniy Safronov on 21.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import UIKit
import Cocaine

class NavigationController: UINavigationController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        DependencyProvider.loadDependences();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for child in childViewControllers where child is IDependenceClient {
            injectClient(client: child as! IDependenceClient);
        }
    }
}
