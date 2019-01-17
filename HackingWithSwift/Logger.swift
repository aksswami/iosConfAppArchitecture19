//
//  Logger.swift
//  HackingWithSwift
//
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

protocol LoggerHandle {
    func log(_ message: String)
}
class Logger {
    private static let sharedLogger = Logger()

    static var shared: Logger {
        return sharedLogger
    }

    fileprivate init() { }

    func log(_ message: String) {
        print(message)
    }

    static func log(_ message: String) {
        shared.log(message)
    }
}

extension LoggerHandle {
    func log(_ message: String) {
        Logger.shared.log(message)
    }
}

extension UIViewController: LoggerHandle {
}
