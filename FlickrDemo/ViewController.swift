//
//  ViewController.swift
//  FlickrDemo
//
//  Created by Hong James on 2019/7/22.
//  Copyright © 2019 Hong James. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let searchTextField = UITextField()
    let countTextField = UITextField()
    let searchButton = UIButton(type: UIButtonType.system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        
        // Do any additional setup after loading the view.
    }

    private func initUI() {
        self.navigationItem.title = "搜尋輸入頁"
        
        self.view.addSubview(self.searchTextField)
        self.view.addSubview(self.countTextField)
        self.view.addSubview(self.searchButton)

        self.countTextField.delegate = self
        self.countTextField.borderStyle = .roundedRect
        self.countTextField.tag = 0
        self.countTextField.placeholder = "每頁呈現數量"
        self.countTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.countTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(0)
            make.centerX.equalTo(self.view).offset(0)
            make.height.equalTo(30)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
        }
        
        self.searchTextField.delegate = self
        self.searchTextField.borderStyle = .roundedRect
        self.searchTextField.tag = 1
        self.searchTextField.placeholder = "欲搜尋內容"
        self.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.searchTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.countTextField.snp.top).offset(-20)
            make.height.equalTo(30)
            make.left.equalTo(self.countTextField)
            make.right.equalTo(self.countTextField)
        }
        
        self.searchButton.isEnabled = false
        self.searchButton.setTitle("搜尋", for: .normal)
        self.searchButton.setTitleColor(.white, for: .normal)
        self.searchButton.backgroundColor = .lightGray
        self.searchButton.addTarget(self, action: #selector(searchClick), for: UIControlEvents.touchUpInside)
        
        
        self.searchButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.countTextField.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.left.equalTo(self.countTextField)
            make.right.equalTo(self.countTextField)
        }
        
        
    }

    @objc private func searchClick() {
        let resultViewController = ResultViewController()
        
        resultViewController.view.backgroundColor = .white
        resultViewController.resultCount = Int(self.countTextField.text!) ?? 0
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch textField.tag {
        case 0:
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        default:
            break
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if (searchTextField.text?.isEmpty)! || (countTextField.text?.isEmpty)! {
            self.searchButton.backgroundColor = .lightGray
            self.searchButton.isEnabled = false
        } else {
            self.searchButton.backgroundColor = searchButton.tintColor
            self.searchButton.isEnabled = true
        }
    }
}
