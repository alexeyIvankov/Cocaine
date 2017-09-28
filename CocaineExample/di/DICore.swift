//
//  DICore.swift
//  CocaineExample
//
//  Created by Alexey Ivankov on 28.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation
import UIKit

public func inject<T>() -> T!{
    
    let application:Application = UIApplication.shared as! Application
    return application.injector.inject()
    
}
