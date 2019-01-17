//
//  Bundle+Extension.swift
//  HackingWithSwift
//
//  Created by Amit Kumar Swami on 17/1/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(from filename: String) -> T  {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to locate projects.json in app bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load projects.json in app bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let value = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode projects.json from app bundle.")
        }
        
        return value
    }
}
