//
//  DependencyProviderNavigationController.swift
//  Cocaine
//
//  Created by Evgeniy Safronov on 21.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Cocaine

class DependencyProvider: IDependenceProvider  {
    public static func loadDependences() {
        loadDependence(dependence: Logger(), key: String(describing: ILogger.self), memoryPolicy: .Strong)
    }
}
