//
//  UIViewController+Dependence.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 18.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation
import  UIKit

extension NSObject
{
    public func injectDependences()
    {
        if let client:IDependenceClient = self as? IDependenceClient
        {
            dependenceEnginge.inject(client: client);
        }
    }
}
