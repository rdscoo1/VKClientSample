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
    private let itemsPerRow: CGFloat = 5
    private let sectionInsets = UIEdgeInsets(top: 5.0,
    left: 5.0,
    bottom: 5.0,
    right: 5.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      //2
      let width = UIScreen.main.bounds.size.width - 5 * CGFloat(itemsPerRow - 1)
      return CGSize(width: floor(width / itemsPerRow), height: width / itemsPerRow)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
      return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
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
}

//class CustomLayout: UICollectionViewFlowLayout {
//    let itemSpacing: CGFloat = 3
//    let itemsInOneLine: CGFloat = 3
//    let width = UIScreen.main.bounds.size.width - self.itemSpacing * CGFloat(self.itemsInOneLine - 1)
//    override var itemSize: CGSize = CGSize(width: floor(width/itemsInOneLine), height: width/itemsInOneLine)
//    minimumInteritemSpacing: CGFloat = 3
//    override var minimumLineSpacing: CGFloat = 3
//}
