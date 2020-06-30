//
//  FriendCollectionVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 21.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class FriendCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let vkApi = VKApi()
    var friendId = Int()
    private var friendPhotos = [Photo]()
    private var photosUrlsLowRes = [String?]()
    private var photosUrlsHighRes = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        vkApi.getPhotos(ownerId: friendId) { [weak self] in
            self?.loadData()
        }
    }
    
    private func loadData() {
        self.friendPhotos = RealmService.manager.getAllObjects(of: Photo.self, with: NSPredicate(format: "ownerId == %ld", friendId))
        self.handleArray(of: friendPhotos)
        self.collectionView.reloadData()
    }
    
    private func handleArray(of array: [Photo]) {
        photosUrlsLowRes = [String?]()
        photosUrlsHighRes = [String?]()
        array.forEach {
            let photoLinklowRes = $0.sizes.first(where: { $0.type == "o" })?.url
            self.photosUrlsLowRes.append(photoLinklowRes)
            
            let photoLinkhighRes = $0.sizes.first(where: { $0.type == "x" })?.url
            self.photosUrlsHighRes.append(photoLinkhighRes)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = Constants.Colors.vkBlue
    }
}


extension FriendCollectionVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosUrlsLowRes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCVCell.reuseId, for: indexPath) as? FriendCVCell
            else { return UICollectionViewCell() }
        guard let friendPhotos = photosUrlsLowRes[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        if let photoUrl = URL(string: friendPhotos) {
            cell.friendPhoto.kf.indicatorType = .activity
            cell.friendPhoto.kf.setImage(with: photoUrl)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoPreviewVC") as! PhotoPreviewVC
        
        vc.friendPreviewPhotos = photosUrlsHighRes
        vc.selectedPhoto = indexPath.row
        vc.friendPhotosQuantity = photosUrlsHighRes.count
        vc.photosPreviewNavBar.setNavBarTitle(selectedPhotoNumber: indexPath.row, photoQuantity: photosUrlsHighRes.count)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    //MARK: - Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 1.0
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
