//
//  FullScreenWebViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 25/10/24.
//

import Foundation
import UIKit
import WebKit

class FullScreenWebViewController: UIViewController {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Set the view in landscape
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        
        // Layout webView
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func loadWithConfiguration(_ configuration: WKWebViewConfiguration, navigationAction: WKNavigationAction) {
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.load(navigationAction.request)
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    // Override this to reset orientation on dismiss
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
}
