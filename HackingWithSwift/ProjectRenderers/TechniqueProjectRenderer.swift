//
//  TechniqueProjectRenderer.swift
//  HackingWithSwift
//
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

struct TechniqueProjectRenderer: Renderer {
    var imageName: String
    var project: Project
    var colors = [UIColor(red: 238/255.0, green: 79/255.0, blue: 182/255.0, alpha: 1), UIColor(red: 201/255.0, green: 68/255.0, blue: 255/255.0, alpha: 1)]

    init(for project: Project) {
        self.project = project
        self.imageName = project.title
    }

    func render(_ colors: [UIColor], scale: CGFloat) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale
        format.opaque = true
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 400, height: 200), format: format)

        return renderer.image { ctx in
            let colorSpace = ctx.cgContext.colorSpace ?? CGColorSpaceCreateDeviceRGB()
            let cgColors = colors.map { $0.cgColor } as CFArray

            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: [0, 1]) else {
                fatalError("Failed creating gradient.")
            }

            ctx.cgContext.drawLinearGradient(gradient, start: CGPoint.zero, end: CGPoint(x: 0, y: 200), options: [])

            let shadow = NSShadow()
            shadow.shadowColor = UIColor.purple
            shadow.shadowBlurRadius = 5

            let text = "Technique Project"
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 32, weight: .bold), .shadow: shadow]
            let string = NSAttributedString(string: text, attributes: attributes)
            string.draw(at: CGPoint(x: 20, y: 150))
        }
    }
}
