//
//  PhotoPreviewVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 06.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PhotoPreviewVC: UIViewController {
    
//    let previousPhoto = UIImageView()
//    let nextPhoto = UIImageView()
    
    let currentPhoto = UIImageView()
    let photosPreviewNavBar = PhotoPreviewNavBarView(selectedPhotoNumber: 0, photosQuantity: 10)
    let photoPreviewFooter = PhotoPreviewFooter()
    var isToolBarsOpened: Bool = false
    
    var friendPreviewPhotos: [String]!
    var friendPhotosQuantity: Int = 0
    var selectedPhoto = 0
    
    var isStatusBarHidden: Bool = true {
        didSet {
            if oldValue != self.isStatusBarHidden {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

         configureUI()
        
        view.addSubview(currentPhoto)
//        view.addSubview(photosPreviewNavBar)
//        view.addSubview(photoPreviewFooter)
        setConstraints()
        
        configureSwipeGestures()
//        addGesture(view: currentPhoto)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func configureUI() {
        view.backgroundColor = .black
        
        currentPhoto.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue | UIView.AutoresizingMask.flexibleLeftMargin.rawValue | UIView.AutoresizingMask.flexibleTopMargin.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue)
        currentPhoto.contentMode = .scaleAspectFit
        currentPhoto.clipsToBounds = true
        currentPhoto.isUserInteractionEnabled = true
        currentPhoto.image = UIImage(imageLiteralResourceName: friendPreviewPhotos[selectedPhoto])
        
        photosPreviewNavBar.alpha = 0.0
        photoPreviewFooter.alpha = 0.0
    }
    
    private func setConstraints() {
        currentPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentPhoto.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentPhoto.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 9.0 / 16.0)
        ])
        
//        photosPreviewNavBar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            photosPreviewNavBar.topAnchor.constraint(equalTo: view.topAnchor),
//            photosPreviewNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            photosPreviewNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            photosPreviewNavBar.heightAnchor.constraint(equalToConstant: 64)
//        ])
//
//        photoPreviewFooter.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            photoPreviewFooter.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            photoPreviewFooter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            photoPreviewFooter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            photoPreviewFooter.heightAnchor.constraint(equalToConstant: 32)
//        ])
    }
    
//    private func addGesture(view: UIView) {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handeTapGesture))
//        view.addGestureRecognizer(tap)
////        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
////        view.addGestureRecognizer(pan)
//    }
    
    @objc func handeTapGesture(sender: UITapGestureRecognizer) {
        isToolBarsOpened = !isToolBarsOpened
        
        if isToolBarsOpened {
            UIView.animate(withDuration: 0.3, animations: {
                self.photosPreviewNavBar.alpha = 1.0
                self.photoPreviewFooter.alpha = 1.0
                self.isStatusBarHidden = !self.isStatusBarHidden
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.photosPreviewNavBar.alpha = 0.0
                self.photoPreviewFooter.alpha = 0.0
                self.isStatusBarHidden = !self.isStatusBarHidden
            })
        }
    }
//
//    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
//        let currentPhoto = sender.view!
//
//        switch sender.state {
//        case .began, .changed:
//            moveWithPan(view: currentPhoto, sender: sender)
//        case .ended:
//            print("PanGesture ended")
//        default:
//            break
//        }
//    }
    
    func moveWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    private func configureSwipeGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handeTapGesture))
//        self.view.addGestureRecognizer(tap)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                self.dismiss(animated: true, completion: nil)
            case UISwipeGestureRecognizer.Direction.left:
                if selectedPhoto == friendPreviewPhotos.count - 1 {
                    selectedPhoto = 0
                } else {
                    selectedPhoto += 1
                }
                currentPhoto.image = UIImage(named: friendPreviewPhotos[selectedPhoto])
            case UISwipeGestureRecognizer.Direction.right:
                if selectedPhoto == 0 {
                    selectedPhoto = friendPreviewPhotos.count - 1
                } else {
                    selectedPhoto -= 1
                }
                currentPhoto.image = UIImage(named: friendPreviewPhotos[selectedPhoto])
            default:
                break
            }
        }
    }
    
}
