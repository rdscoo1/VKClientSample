//
//  FriendCollectionVC.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 21.01.2020.
//  Copyright © 2020 Roman Khodukin. All rights reserved.
//

import UIKit

class FriendCollectionVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var friendPhotos = [String]()
    var friendPhotosQuantity: Int = 0
    var friendId: Int = -1
    var friendModel: [VKPhoto] = []
    var photosUrls = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendPhotosQuantity = friendPhotos.count
        
        requestFromApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }    
    
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
    
    // MARK: - UICollectionViewDataSource
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return friendModel.count
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosUrls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCVCell.reuseId, for: indexPath) as? FriendCVCell
            else { return UICollectionViewCell() }
//        let friendPhoto = friendModel[indexPath.section].sizes[indexPath.row].url
//        print("Ячейка \(friendPhoto)")
        guard let friendPhotos = photosUrls[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        if let photoUrl = URL(string: friendPhotos) {
            cell.friendPhoto.kf.setImage(with: photoUrl)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PhotoPreviewVC") as! PhotoPreviewVC
        
        vc.friendPreviewPhotos = friendPhotos
        let selectedPhotoNumber = indexPath.row
        vc.selectedPhoto = selectedPhotoNumber
        vc.photosPreviewNavBar.photosQuantityLabel.text = "\(selectedPhotoNumber + 1) of \(friendPhotos.count)"
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationController!.navigationBar.tintColor = .white
    }
    
    //MARK: - Load and handle Data
    
    //    func handlePhoto(items: [VKPhoto]) -> [VKPhoto]  {
    //        var friendPhotos: [VKPhoto] = []
    //
    //        items.forEach { (photo) in
    //            var newPhoto: VKPhoto?
    //            newPhoto?.id = photo.id
    //            newPhoto?.text = photo.text
    //            newPhoto?.albumId = photo.albumId
    //            newPhoto?.ownerId = photo.ownerId
    //
    //            photo.sizes.forEach { (size) in
    //                var photoSize: VKPhoto.Size?
    //                photoSize?.type = size.type
    //                photoSize?.width = size.width
    //                photoSize?.height = size.height
    //                photoSize?.url = size.url
    //                newPhoto?.sizes.append(photoSize!)
    //            }
    //            friendPhotos.append(newPhoto? ?? [])
    //        }
    //
    //        return friendPhotos
    //
    //    }
    
    private func requestFromApi() {
        let token = Session.shared.token
        let userId = Session.shared.userId
        let vkApi = VKApi(token: token, userId: userId)
        
        vkApi.getPhotos(ownerId: friendId) { [weak self] photos in
            self?.friendModel = photos
            photos.forEach {
                let photoLink = $0.sizes.first(where: { $0.type == "m" })?.url
                self?.photosUrls.append(photoLink)
//                print("photo url-> ", photoLink)
            }
            
            self?.collectionView.reloadData()
        }
    }
}
