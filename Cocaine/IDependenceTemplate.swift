//
//  IDependenceTemplate.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 16.01.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public protocol IDependenceTemplate :  IDependence,  NSCopying {
    func configure(parametrs:Parametrs?);
}
