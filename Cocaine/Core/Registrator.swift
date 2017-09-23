//
//  DependenceRegistrator.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 23.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

protocol Registrator {
 
    func register<T: AnyObject>(_ build:()->T, memoryPolicy: DependenceMemoryPolicy )
    func register<T: AnyObject>(key:String, _ build:()->T, memoryPolicy: DependenceMemoryPolicy)
}
