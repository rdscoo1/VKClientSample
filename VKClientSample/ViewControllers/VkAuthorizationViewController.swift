//
//  VkAuthorizationViewController.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class VkAuthorizationViewController: UIViewController {
    
    // MARK: - Variables
    
    private let webView = WKWebView()
    private let activityIndicator = CustomActivityIndicator(frame: CGRect(x: 0, y: 0, width: 96, height: 96))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        configureWebView()
    }
    
    // MARK: - Private Methods
    
    private func configureWebView() {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7627564"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,photos,stories,wall,groups,status,offline"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.124")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.navigationDelegate = self
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Navigation
    
    private func goToTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC")
        
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
}

// MARK: - WKNavigationDelegate

extension VkAuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String] ()) { result, param in
                var dict = result //создаем словать с результатом url
                let key = param[0] //получаем параметры (access_token, expires_in, user_id)
                let value = param[1] //получаем значения параметров
                dict[key] = value
                return dict
            }
        
        Session.shared.token = params["access_token"] ?? ""
        Session.shared.userId = params["user_id"] ?? ""
        UserDefaults.standard.userId = params["user_id"] ?? ""
        
        goToTabBar()
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
