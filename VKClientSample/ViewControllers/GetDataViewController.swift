//
//  GetDataViewController.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 25.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class GetDataViewController: UIViewController {

    lazy var getDataButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выполнить запрос", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(getDataButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(getDataButton)
        
        getDataButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc func getDataButtonTapped() {
        let token = Session.shared.token
        let userId = Session.shared.userId
        let vkApi = VKApi(token: token, userId: userId)
        
        
        vkApi.getGroups { result in
            print(result)
        }

        
        vkApi.getSearchedGroups(groupName: "Music") { result in
            print(result)
        }
    }

}
