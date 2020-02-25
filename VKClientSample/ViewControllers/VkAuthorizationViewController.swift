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
            URLQueryItem(name: "scope", value: "262150"),
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
        if let navigationController =  UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
            navigationController.pushViewController(GetDataViewController(), animated: true)
        }
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
        Session.shared.userId = params["user_id"] ?? "0"
        
        goToGetDataVC()
        
        decisionHandler(.cancel)
    }
}
