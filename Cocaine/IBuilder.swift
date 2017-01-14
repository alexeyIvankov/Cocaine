//
//  IBuilder.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 14.01.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

@objc public protocol IBuilder : AnyObject {
    
    var key:String { get }
    
    func build_dependence(pr1:AnyObject? ,
                          pr2:AnyObject?,
                          pr3:AnyObject?,
                          pr4:AnyObject?,
                          pr5:AnyObject?,
                          pr6:AnyObject?,
                          pr7:AnyObject?,
                          pr8:AnyObject?) -> IDependence?;
}
