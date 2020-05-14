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

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        configureWebView()
    }
    
    func configureWebView() {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7334032"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.103")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        print(request)
        
        webView.load(request)
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.navigationDelegate = self
        
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func goToGetDataVC() {
        let vc = (storyboard?.instantiateViewController(withIdentifier: "TabBarVC"))!
        navigationController?.pushViewController(vc, animated: true)
    }
}

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
        
        let params = fragment.components(separatedBy: "&")
                            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { value, params in
            var dict = value
            let key = params[0]
            let value = params[1]
            dict[key] = value
            return dict
        }
        
        Session.shared.token = params["access_token"] ?? ""
        Session.shared.userId = params["user_id"] ?? ""
        UserDefaults.standard.isAuthorized = true
                
        decisionHandler(.cancel)
        goToGetDataVC()
    }
}
