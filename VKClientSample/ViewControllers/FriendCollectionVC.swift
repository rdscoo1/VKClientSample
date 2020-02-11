//
//  FriendCollectionVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 21.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class FriendCollectionVC: UICollectionViewController {
    
    var friendPhotos: [String]!
    var friendPhotosQuantity: Int = 0
    private let itemsPerRow: CGFloat = 5
    private let sectionInsets = UIEdgeInsets(top: 5.0,
                                             left: 5.0,
                                             bottom: 5.0,
                                             right: 5.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendPhotosQuantity = friendPhotos.count
        
//        collectionView.register(FriendCVCell.self, forCellWithReuseIdentifier: FriendCVCell.reuseId)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        
        return CGSize(width: bounds.width / 3 - 10, height: bounds.height / 4 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCVCell.reuseId, for: indexPath) as? FriendCVCell
            else {
                return UICollectionViewCell()
        }
        
        cell.friendPhoto.image = UIImage(imageLiteralResourceName: friendPhotos[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoPreviewVC") as! PhotoPreviewVC
          
        vc.friendPreviewPhotos = friendPhotos
        vc.selectedPhoto = indexPath.row
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = .white
    }
}
