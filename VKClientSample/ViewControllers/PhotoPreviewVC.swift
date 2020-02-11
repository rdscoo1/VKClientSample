//
//  PhotoPreviewVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 06.02.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class PhotoPreviewVC: UIViewController {
    
    let previousPhoto = UIImageView()
    let currentPhoto = UIImageView()
    let nextPhoto = UIImageView()
    
    var friendPreviewPhotos: [String]!
    var friendPhotosQuantity: Int = 0
    var selectedPhoto = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(currentPhoto)
//        addPanGesture(view: currentPhoto)
        
        configurePhotos()
        configureSwipeGestures()
    }
    
    private func configurePhotos() {
        currentPhoto.isUserInteractionEnabled = true
        currentPhoto.image = UIImage(imageLiteralResourceName: friendPreviewPhotos[selectedPhoto])
        
        nextPhoto.isUserInteractionEnabled = true
        nextPhoto.image = UIImage(imageLiteralResourceName: friendPreviewPhotos[selectedPhoto + 1])
        
        currentPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentPhoto.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentPhoto.heightAnchor.constraint(equalToConstant: 288)
        ])
        
//        nextPhoto.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            nextPhoto.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            nextPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            nextPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            nextPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            nextPhoto.heightAnchor.constraint(equalToConstant: 288)
//        ])
    }
    
    private func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handleGesture(sender: UIPanGestureRecognizer) {
        let photoImageView = sender.view!
        
        switch sender.state {
        case .began, .changed:
            moveWithPan(view: currentPhoto, sender: sender)
        case .ended:
            print("PanGesture ended")
        default:
            break
        }
    }
    
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
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                self.dismiss(animated: true, completion: nil)
//            case UISwipeGestureRecognizer.Direction.left:
//                if selectedPhoto == friendPreviewPhotos.count - 1 {
//                    selectedPhoto = 0
//                } else {
//                    selectedPhoto += 1
//                }
//                currentPhoto.image = UIImage(named: friendPreviewPhotos[selectedPhoto])
//            case UISwipeGestureRecognizer.Direction.right:
//                if selectedPhoto == 0 {
//                    selectedPhoto = friendPreviewPhotos.count - 1
//                } else {
//                    selectedPhoto -= 1
//                }
//                currentPhoto.image = UIImage(named: friendPreviewPhotos[selectedPhoto])
            default:
                break
            }
        }
    }
    
}
