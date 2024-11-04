//
//  WatchMovieController.swift
//  Movier
//
//  Created by Shivam Kumar on 29/10/24.
//

import Foundation
import UIKit
import WebKit

class WatchMovieController : UIViewController {
    
    lazy var webView : WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = [.all]
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.clipsToBounds = true
        return webView
    }()
    
    private let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .systemRed
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.addSubview(activityIndicator)
        webView.navigationDelegate = self
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
        ])
    }
    
    func configure(with viewModel : DetailViewModel){
        DispatchQueue(label: "Movie Thread", attributes: .concurrent).async {
            let contentId = viewModel.id
            guard let contentType = viewModel.contentType else {return}
            if contentType == "movie" {
                DispatchQueue.main.async {
                    guard let url = URL(string: "https://soap2day7.xyz/watch-movie-\(contentId)-soap2day") else {return}
                    print("\(contentType) have url \(url)")
                    self.webView.load(URLRequest(url: url))
                }
            }
            else if contentType == "tv" {
                DispatchQueue.main.async {
                    guard let url = URL(string: "https://soap2day7.xyz/watch-\(contentType)series-\(contentId)&season=1&episode=1") else {return}
                    print("\(contentType) have url \(url)")
                    self.webView.load(URLRequest(url: url))
                }
            }
        }
    }
}

extension WatchMovieController : WKNavigationDelegate , WKUIDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        activityIndicator.stopAnimating()
        print("Failed to load : \(error.localizedDescription)")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let fullScreenVC = FullScreenWebViewController()
        fullScreenVC.modalPresentationStyle = .fullScreen
        fullScreenVC.loadWithConfiguration(configuration, navigationAction: navigationAction)
        present(fullScreenVC, animated: true,completion: nil)
        return fullScreenVC.webView
    }
}
