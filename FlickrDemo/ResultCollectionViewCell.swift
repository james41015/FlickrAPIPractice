//
//  ResultCollectionViewCell.swift
//  FlickrDemo
//
//  Created by Hong James on 2019/7/22.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit
import SnapKit

class ResultCollectionViewCell: UICollectionViewCell {
    var resultImageView = UIImageView()
    var titleLabel = UILabel()
    var collectButton = UIButton(type: UIButtonType.system)
    var collectCallBack: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel.textAlignment = .center
        self.collectButton.setTitle("收藏", for: .normal)
        self.collectButton.setTitleColor(.white, for: .normal)
        self.collectButton.backgroundColor = .red
        self.collectButton.addTarget(self, action: #selector(collectClick), for: UIControlEvents.touchUpInside)
        
        self.contentView.addSubview(resultImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(collectButton)
        
        self.collectButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalTo(40)
            make.right.equalTo(self.resultImageView.snp.right).offset(0)
            make.top.equalTo(self.resultImageView.snp.top).offset(0)
        }
        
        self.resultImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(self.contentView).offset(-40)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func collectClick() {
        self.collectCallBack?()
    }
}
