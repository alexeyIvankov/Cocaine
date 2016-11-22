//
//  Builder.swift
//  Cocaine
//
//  Created by Alexey Ivankov on 18.11.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

public let dependenceEnginge:DependenceEngine = Builder.buildDependenceEngine();

public class Builder
{
    public static func buildDependenceEngine() -> DependenceEngine
    {
        return DependenceEngine();
    }
}
