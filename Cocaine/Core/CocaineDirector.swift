//
//  CocaineDirector.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 23.09.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

protocol CocaineDirector {
    
    var registrator:Registrator { get }
    var injector:Injector { get }
}
