//
//  PhotoPreviewVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 06.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PhotoPreviewVC: UIViewController {
    
    let photosPreviewNavBar = PhotoPreviewNavBarView()
    private let photoPreviewFooter = PhotoPreviewFooter()
    private var isToolBarOpened: Bool = false
    
    private let currentPhoto = UIImageView()
    var friendPreviewPhotos = [String?]()
    var friendPhotosQuantity = Int()
    var selectedPhoto = Int()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(currentPhoto)
        view.addSubview(photosPreviewNavBar)
        view.addSubview(photoPreviewFooter)
        
        configureUI()
        setConstraints()
        
        configureSwipeGestures()
    }
    
    private func configureUI() {
        currentPhoto.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleBottomMargin.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue | UIView.AutoresizingMask.flexibleRightMargin.rawValue | UIView.AutoresizingMask.flexibleLeftMargin.rawValue | UIView.AutoresizingMask.flexibleTopMargin.rawValue | UIView.AutoresizingMask.flexibleWidth.rawValue)
        currentPhoto.contentMode = .scaleAspectFit
        currentPhoto.clipsToBounds = true
        currentPhoto.isUserInteractionEnabled = true
        
        if let photoUrl = URL(string: friendPreviewPhotos[selectedPhoto]!) {
            currentPhoto.kf.indicatorType = .activity
            currentPhoto.kf.setImage(with: photoUrl,
                                     options: [
                                         .transition(.fade(1)),
                                     ])
        }
        
        photosPreviewNavBar.alpha = 0.0
        photoPreviewFooter.alpha = 0.0
        
        photosPreviewNavBar.addButtonTarget(target: self, action: #selector(dissmissPhotoPreviewVC))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handeTapGesture))
        view.addGestureRecognizer(tap)
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
        
        photosPreviewNavBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photosPreviewNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            photosPreviewNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photosPreviewNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosPreviewNavBar.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        photoPreviewFooter.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoPreviewFooter.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photoPreviewFooter.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            photoPreviewFooter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            photoPreviewFooter.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    @objc func dissmissPhotoPreviewVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handeTapGesture(sender: UITapGestureRecognizer) {
        isToolBarOpened = !isToolBarOpened
        
        if isToolBarOpened {
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
}

extension PhotoPreviewVC: UIGestureRecognizerDelegate {
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
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                self.dismiss(animated: true, completion: nil)
            case UISwipeGestureRecognizer.Direction.left:
                if selectedPhoto != friendPreviewPhotos.count - 1 {
                    selectedPhoto += 1
                    if let photoUrl = URL(string: friendPreviewPhotos[selectedPhoto]!) {
                        currentPhoto.kf.setImage(with: photoUrl)
                    }
                    photosPreviewNavBar.setNavBarTitle(selectedPhotoNumber: selectedPhoto, photoQuantity: friendPhotosQuantity)
                }
            case UISwipeGestureRecognizer.Direction.right:
                if selectedPhoto != 0 {
                    selectedPhoto -= 1
                    if let photoUrl = URL(string: friendPreviewPhotos[selectedPhoto]!) {
                        currentPhoto.kf.setImage(with: photoUrl)
                    }
                    photosPreviewNavBar.setNavBarTitle(selectedPhotoNumber: selectedPhoto, photoQuantity: friendPhotosQuantity)
                }
            default:
                break
            }
        }
    }
}
