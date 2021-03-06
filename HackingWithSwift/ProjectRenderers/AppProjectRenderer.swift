//
//  AppProjectRenderer.swift
//  HackingWithSwift
//
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

struct AppProjectRenderer: Renderer {
    var imageName: String
    var project: Project
    var colors = [UIColor(red: 27/255.0, green: 215/255.0, blue: 253/255.0, alpha: 1), UIColor(red: 30/255.0, green: 98/255.0, blue: 241/255.0, alpha: 1)]

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
            shadow.shadowColor = UIColor.blue
            shadow.shadowBlurRadius = 5

            let text = "App Project"
            let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 32, weight: .bold), .shadow: shadow]
            let string = NSAttributedString(string: text, attributes: attributes)
            string.draw(at: CGPoint(x: 20, y: 150))
        }
    }
}


protocol Renderer {
    var colors: [UIColor] { get }
    var imageName: String { get }
    
    func drawTitleImage() -> UIImage
    func cache(_ image: UIImage, named: String)
    func getCachesDirectory() -> URL
    func imageFromCache(_ named: String, scale: CGFloat) -> UIImage?
    func render(_ colors: [UIColor], scale: CGFloat) -> UIImage
}


extension Renderer {
    func getCachesDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func cache(_ image: UIImage, named: String) {
        let url = getCachesDirectory().appendingPathComponent(named)
        try? image.pngData()?.write(to: url)
    }
    
    func imageFromCache(_ named: String, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        let url = getCachesDirectory().appendingPathComponent(named)
        let fm = FileManager.default
        
        if fm.fileExists(atPath: url.path) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data, scale: scale)
            }
        }
        
        return nil
    }
    
    func drawTitleImage() -> UIImage {
        if let cached = imageFromCache(imageName) {
            return cached
        }
        
        let image = render(colors, scale: UIScreen.main.scale)
        cache(image, named: imageName)
        
        return image
    }
}

