//
//  ResultViewController.swift
//  FlickrDemo
//
//  Created by Hong James on 2019/7/22.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ResultViewController: UIViewController {
    
    var resultCollectionView: UICollectionView!
    var text: String! = ""
    var perPage: Int! = 0
    var photosArray = [PhotoModel]()
    var searchPhotosArray = [PhotoModel]()
    var favoritesPhotosArray = [PhotoModel]()
    
    let viewModel = ResultViewModel()
    //tabbar
    var tabbar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        self.resultCollectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ResultCollectionViewCell.self))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.search(text: text, perPage: perPage) { (searchResponseModel, error) in
            self.searchPhotosArray.removeAll()
            if let searchResponse = searchResponseModel {
                if let photoModel = searchResponse.photos {
                    if let photos = photoModel.photo {
                        for photo in photos {
                            self.searchPhotosArray.append(photo)
                        }
                    }
                }
            }
            self.photosArray = self.searchPhotosArray
            self.navigationItem.title = "搜尋結果 \(self.text!)"
            self.resultCollectionView.reloadData()
        }
    }
    
    private func initUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0.0
        
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.scrollDirection = .vertical
        
        self.resultCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        self.resultCollectionView.delegate = self
        self.resultCollectionView.dataSource = self
        self.resultCollectionView.backgroundColor = .white
        
        self.tabbar = UITabBar()
        self.tabbar.delegate = self
        
        var items = [UITabBarItem]()
        items.append(UITabBarItem(tabBarSystemItem: .featured, tag: 0))
        items.append(UITabBarItem(tabBarSystemItem: .favorites, tag: 1))
        
        self.tabbar.setItems(items, animated: true)
        self.tabbar.selectedItem = items[0]
        
        self.view.addSubview(self.tabbar)
        self.tabbar!.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.snp.bottomMargin)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        
        self.view.addSubview(self.resultCollectionView)
        self.resultCollectionView!.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.tabbar.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
    }

    

}

extension ResultViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ResultCollectionViewCell.self), for: indexPath) as! ResultCollectionViewCell
        //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        let farmId = self.photosArray[indexPath.row].farm
        let serverId = self.photosArray[indexPath.row].server
        let id = self.photosArray[indexPath.row].id
        let secret = self.photosArray[indexPath.row].secret
        let imageUrl = URL(string: "https://farm\(String(describing: farmId!)).staticflickr.com/\(String(describing: serverId!))/\(String(describing: id!))_\(String(describing: secret!)).jpg")
        cell.resultImageView.kf.setImage(with: imageUrl)
        cell.titleLabel.text = self.photosArray[indexPath.row].title
        
        cell.collectButton.isHidden = self.tabbar.selectedItem!.tag == 1
        
        cell.collectCallBack = {
            self.favoritesPhotosArray.append(self.photosArray[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2 + 30)
    }
    
}

extension ResultViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            self.photosArray = self.searchPhotosArray
            self.navigationItem.title = "搜尋結果 \(self.text!)"
        case 1:
            self.photosArray = self.favoritesPhotosArray
            self.navigationItem.title = "我的最愛"
        default:
            break
        }
        self.resultCollectionView.reloadData()
    }
}
