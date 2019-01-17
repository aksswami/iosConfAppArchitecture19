//
//  ProjectListViewModel.swift
//  HackingWithSwift
//
//  Created by Amit Kumar Swami on 17/1/19.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import Foundation
import UIKit

struct ProjectListViewModel {
    var projects: [Project]
    
}

extension Project {
    
    var displayText: NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        
        titleString.append(subtitleString)
        
        return titleString
    }
    
    var image: UIImage {
        if number % 3 == 1 {
            let renderer = AppProjectRenderer(for: self)
            return renderer.drawTitleImage()
        } else if number % 3 == 2 {
            let renderer = GameProjectRenderer(for: self)
            return renderer.drawTitleImage()
        } else {
            let renderer = TechniqueProjectRenderer(for: self)
            return renderer.drawTitleImage()
        }
    }
}
