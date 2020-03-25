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
    var friendModel: [Photo<VKPhotoProtocol>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendPhotosQuantity = friendPhotos.count
        
        loadData()
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return friendModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendModel[section].sizes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCVCell.reuseId, for: indexPath) as? FriendCVCell
            else {
                return UICollectionViewCell()
        }
        let friendPhoto = friendModel[indexPath.section].sizes[0]
        print("Ячейка \(friendPhoto)")
//        let photoLink = friendPhoto
//
//        if let photoUrl = URL(string: photoLink) {
//            cell.friendPhoto.kf.setImage(with: photoUrl)
//        }
            
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
    
    func handlePhoto(items: [VKFriendProtocol]) -> [Section<VKFriendProtocol>] {
        return Dictionary(grouping: items) { $0.lastName.prefix(1) }
            .map { Section<VKFriendProtocol>(title: "\($0.key)", items: $0.value) }
            .sorted(by: { $0.title < $1.title })
    }
    
    private func loadData() {
        requestFromApi { items in
//            print("👥 photos: ", items)
            self.friendModel.append(Photo(sizes: items))
//            let photoLink = sizes.first(where: { $0.type == "x" })?.url
            self.collectionView.reloadData()
        }
    }
    
    private func requestFromApi(completion: @escaping ([VKPhotoProtocol]) -> Void) {
        let token = Session.shared.token
        let userId = Session.shared.userId
        let vkApi = VKApi(token: token, userId: userId)
        
        vkApi.getAllPhotos(ownerId: String(friendId)) { response in
            switch response {
            case let .success(models):
                if let items = models.response?.items {
                    let size = items[1].sizes[0].url
                    print("\n \(size)")
                    completion(items)
                } else if
                    let errorCode = models.error?.error_code,
                    let errorMsg = models.error?.error_msg
                {
                    print("❌ #\(errorCode) \(errorMsg)")
                }
            case let .failure(error):
                print("❌ \(error)")
            }
        }
    }
}
