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
    
    let viewModel = ResultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
        self.resultCollectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ResultCollectionViewCell.self))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.search(text: text, perPage: perPage) { (searchResponseModel, error) in
            self.photosArray.removeAll()
            if let searchResponse = searchResponseModel {
                if let photoModel = searchResponse.photos {
                    if let photos = photoModel.photo {
                        for photo in photos {
                            self.photosArray.append(photo)
                        }
                    }
                }
            }
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

        
        self.view.addSubview(self.resultCollectionView)
        self.resultCollectionView!.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2 + 30)
    }
}
