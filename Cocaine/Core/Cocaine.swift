//
//  DependenceCore.swift
//  Cocaine
//
//  Created by Nikita on 27.07.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

public class Cocaine : I_Cocaine
{
    public let registrator: I_Registrator
    public let injector: I_Injector
    
    required public init(registrator:I_Registrator,
                         injector:I_Injector) {
        
        self.registrator = registrator
        self.injector = injector
    }
}
