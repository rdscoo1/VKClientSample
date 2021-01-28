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
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var blurView: UIVisualEffectView = {
        let view: UIVisualEffectView = {
            if #available(iOS 13.0, *) {
                return UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
            } else {
                return UIVisualEffectView(effect: UIBlurEffect(style: .light))
            }
        }()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var iconView = DoneIconView()

    private lazy var alertMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = Constants.Colors.vkGray
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        view.addSubview(containerView)
        containerView.addSubview(blurView)
        blurView.contentView.addSubview(iconView)
        blurView.contentView.addSubview(alertMessageLabel)
        
        setupUI()
        configureConstraints()
        view.bringSubviewToFront(containerView)
    }
    
    // MARK: - Private Methods

    private func setupUI() {
        alertMessageLabel.text = message
        
        iconView.alpha = 0
        iconView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(withDuration: 0.2, animations: {
            self.iconView.alpha = 1
            self.iconView.transform = CGAffineTransform.identity
        }, completion: { _ in
            self.iconView.animate()
        })

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupShadow() {
        let shadowLayer = CAShapeLayer()

        shadowLayer.path = UIBezierPath(roundedRect: blurView.bounds,
                                        cornerRadius: 8).cgPath
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.fillColor = Constants.Colors.theme.cgColor
        shadowLayer.shadowColor = Constants.Colors.vkGray.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0.5)
        shadowLayer.shadowOpacity = 0.3
        shadowLayer.shadowRadius = 2.0
        shadowLayer.shouldRasterize = true
        shadowLayer.rasterizationScale = blurView.layer.contentsScale

        blurView.layer.insertSublayer(shadowLayer, at: 0)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            containerView.widthAnchor.constraint(equalToConstant: 136),

            blurView.topAnchor.constraint(equalTo: containerView.topAnchor),
            blurView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),

            iconView.topAnchor.constraint(equalTo: blurView.contentView.topAnchor, constant: 8),
            iconView.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
            iconView.heightAnchor.constraint(equalToConstant: 36),
            iconView.widthAnchor.constraint(equalToConstant: 36),

            alertMessageLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 8),
            alertMessageLabel.trailingAnchor.constraint(equalTo: blurView.contentView.trailingAnchor, constant: -8),
            alertMessageLabel.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: 8)
        ])
    }

    @objc private func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }
}
