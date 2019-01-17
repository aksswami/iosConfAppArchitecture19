//
//  ReadViewController.swift
//  HackingWithSwift
//
//  Copyright © 2018 Hacking with Swift. All rights reserved.
//

import UIKit
import WebKit

class ReadViewController: UIViewController, LoggerHandle {
    var webView = WKWebView()
    var project: Project!
    
    var navigationDelegate: NavigationDelegate?
    let allowedSites = ["apple.com", "hackingwithswift.com"]

    override func loadView() {
        navigationDelegate = NavigationDelegate(allowedSites)
        webView.navigationDelegate = navigationDelegate!

        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(project != nil, "You must set a project before showing this view controller.")
        title = project.title
        log("Read project \(project.number).")

        guard let url = URL(string: "https://www.hackingwithswift.com/read/\(project.number)/overview") else {
            return
        }

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

class NavigationDelegate: NSObject, WKNavigationDelegate {
    private var allowedSites: [String]
    let mock = ApplicationMock()
    
    init(_ allowedSites: [String]) {
        self.allowedSites = allowedSites
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if allowedSites.contains(where: host.contains) {
                decisionHandler(.allow)
                return
            }
        }
        
        if let url = navigationAction.request.url {
            openURL(url, using: mock)
        }
        
        decisionHandler(.cancel)
    }
    
    func openURL(_ url: URL, using: URLOpening = UIApplication.shared) {
        using.open(url, options: [:], completionHandler: nil)
    }
}


protocol URLOpening {
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: URLOpening {
}

class ApplicationMock: URLOpening {
    var urlOpenCount = 0
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any], completionHandler completion: ((Bool) -> Void)? = nil) {
        urlOpenCount += 1
    }
}


