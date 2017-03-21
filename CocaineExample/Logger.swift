//
//  PrintLogger.swift
//  Cocaine
//
//  Created by Evgeniy Safronov on 21.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import Foundation

class Logger: ILogger {
    func log(_ text: String) {
        print(text)
    }
}
