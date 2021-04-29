//
//  AlertViewController.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 10/18/20.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

enum AlertState {
    case success
    case loading
    case failure
}

class AlertViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let containerView = UIView()
    private var iconView = DoneIconView()
    private let alertMessageLabel = UILabel()
    
    private let startedFollowingPhrase = NSLocalizedString("You are now following this community", comment: "")
    private let stoppedFollowingPhrase = NSLocalizedString("You have unfollowed the community", comment: "")
    
    private var message: String!
    
    // MARK: - Initializers
    
    init(message: String) {
        super.init(nibName: nil, bundle: nil)
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupShadow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupUI()
        
        view.addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(alertMessageLabel)
        
        configureConstraints()
        setupShadow()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .clear
        
        containerView.backgroundColor = UIColor(hex: "#fefefe")
        
        iconView.alpha = 0
        iconView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.iconView.alpha = 1
            self.iconView.transform = CGAffineTransform.identity
        }, completion: { _ in
            self.iconView.animate()
        })
        
        alertMessageLabel.text = message
        alertMessageLabel.font = .systemFont(ofSize: 15)
        alertMessageLabel.textColor = Constants.Colors.vkGray
        alertMessageLabel.textAlignment = .center
        alertMessageLabel.numberOfLines = 2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupShadow() {
        let shadowLayer = CAShapeLayer()

        shadowLayer.path = UIBezierPath(roundedRect: containerView.bounds,
                                        cornerRadius: 8).cgPath
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.fillColor = containerView.backgroundColor?.cgColor
        shadowLayer.shadowColor = Constants.Colors.vkGray.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0.5)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 1.0
        shadowLayer.shouldRasterize = true
        shadowLayer.rasterizationScale = containerView.layer.contentsScale

        containerView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    private func configureConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        alertMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            containerView.widthAnchor.constraint(equalToConstant: 136),
            
            iconView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            iconView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 36),
            iconView.widthAnchor.constraint(equalToConstant: 36),
            
            alertMessageLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 8),
            alertMessageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            alertMessageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8)
        ])
    }
    
    @objc private func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }
}
