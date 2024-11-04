//
//  DetailViewController.swift
//  Movier
//
//  Created by Shivam Kumar on 09/10/24.
//

import Foundation
import UIKit
import WebKit


class DetailViewController : UIViewController {
    
    let detailView = DetailView()
    
    private var viewModel : DetailViewModel?
    private var model : TitlePreviewViewModel?
    
    private let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .systemRed
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        detailView.webView.navigationDelegate = self
        detailView.webView2.navigationDelegate = self
        detailView.webView.uiDelegate = self
        detailView.webView2.uiDelegate = self
        setupDetailView()
        webVideoPreview()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.removeFromSuperview()
    }
    
    private func setupDetailView(){
        view.addSubview(detailView)
        detailView.webView.addSubview(activityIndicator)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: detailView.webView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: detailView.webView.centerYAnchor),
        ])
        
        detailView.downloadButton.addTarget(self, action: #selector(downloadMovie), for: .touchUpInside)
        detailView.watchMovieButton.addTarget(self, action: #selector(openWatchMovieController), for: .touchUpInside)
    }
    
    @objc func openWatchMovieController(_ sender : UIButton){
        let watchMovieVC = WatchMovieController()
        watchMovieVC.configure(with: viewModel!)
        navigationController?.pushViewController(watchMovieVC, animated: true)
    }
    
    @objc func downloadMovie(_ sender : UIButton){
        UIView.animate(withDuration: 1.0) {
            sender.tintColor = .systemGreen
            sender.setBackgroundImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
    }
    
    
    func configure(with viewModel : DetailViewModel){
        self.viewModel = viewModel
        detailView.movieImageView.image = UIImage(named: viewModel.movieImagePath ?? "image")
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.movieImagePath ?? "image")") else { return }
        
        detailView.movieImageView.sd_setImage(with: url, completed: nil)
        
        detailView.movieTitleLabel.text =  "\(viewModel.movieName ?? viewModel.movieTitle ?? "Not Available")"
        detailView.movieVoteLabel.text = "Total votes : " + String(viewModel.movieVoteCount)
        detailView.movieOverViewLabel.text = "\(viewModel.movieOverview ?? "Not Available")"
        detailView.mediaTypeValue.text = viewModel.contentType ?? "movie"
        detailView.ratingsValue.text = "\(viewModel.movieVoteAverage) / 10"
        detailView.releaseDateValue.text = viewModel.movieReleaseDate ?? viewModel.tvairDate
        
        if  Int(viewModel.movieVoteCount) > 100 && Int(viewModel.movieVoteCount) <= 500 {
            detailView.voteStackView.addArrangedSubview(detailView.star1)
            detailView.voteStackView.addArrangedSubview(detailView.star2)
            detailView.voteStackView.addArrangedSubview(detailView.star6)
        }
        else if Int(viewModel.movieVoteCount) > 500 && Int(viewModel.movieVoteCount) <= 1000  {
            detailView.voteStackView.addArrangedSubview(detailView.star1)
            detailView.voteStackView.addArrangedSubview(detailView.star2)
            detailView.voteStackView.addArrangedSubview(detailView.star3)
            detailView.voteStackView.addArrangedSubview(detailView.star4)
            detailView.voteStackView.addArrangedSubview(detailView.star6)
        }
        else if Int(viewModel.movieVoteCount) > 1000 {
            detailView.voteStackView.addArrangedSubview(detailView.star1)
            detailView.voteStackView.addArrangedSubview(detailView.star2)
            detailView.voteStackView.addArrangedSubview(detailView.star3)
            detailView.voteStackView.addArrangedSubview(detailView.star4)
            detailView.voteStackView.addArrangedSubview(detailView.star5)
        }
        else{
            detailView.voteStackView.addArrangedSubview(detailView.star1)
            detailView.voteStackView.addArrangedSubview(detailView.star6)
        }
    }
    
    
    func webVideoPreview(){
        guard let titleName = viewModel?.movieName ?? viewModel?.movieTitle else {return}
        DispatchQueue.global(qos: .userInteractive).async {
            APICaller.shared.getMovie(with: titleName + " trailer") {[weak self] results in
                switch results{
                case .success(let videoElement):
                    let videoId = videoElement.id.videoId
                    let youtubeURLString = "https://www.youtube.com/embed/\(videoId)?playsinline=1&autoplay=1"
                    guard let url = URL(string: youtubeURLString) else {return}
                    DispatchQueue.main.async {
                        self?.detailView.webView.load(URLRequest(url: url))
                    }
                case .failure(_):
                    DispatchQueue.main.sync {
                        self?.detailView.webView.isHidden = true
                        self?.detailView.movieImageView.isHidden = false
                        self?.detailView.serverErrorLabel.isHidden = false
                        self?.detailView.serverErrorLabel.text = "Server error in loading trailer."
                    }
                }
            }
        }
        guard var contentType = viewModel?.contentType else {return}
        if contentType == "tv" { contentType = "web series"}
        guard let encodedTitle = titleName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.youtube.com/results?search_query=\(encodedTitle)+\(contentType)") else {return}
        
        DispatchQueue.global(qos: .userInteractive).async {
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                self.detailView.webView2.load(request)
            }
        }
    }
    
    
}

extension DetailViewController : WKNavigationDelegate, WKUIDelegate {
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
