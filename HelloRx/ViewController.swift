//
//  ViewController.swift
//  HelloRx
//
//  Created by 黃瀞萱 on 2021/9/17.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    private enum Title: String {
        case name = "UserName"
        case password = "Password"
        case button = "Press me!"
    }
    
    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    let nameLabel = UILabel()
    let passwordLabel = UILabel()
    let button = UIButton()
    //    let basicCorner: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubView()
    }

    private func setUpSubView() {
        
        [nameLabel, nameTextField, passwordLabel, passwordTextField, button].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        }
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        nameLabel.text = Title.name.rawValue
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.layer.borderWidth = 1
        
        passwordLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        passwordLabel.text = Title.password.rawValue
        
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.borderWidth = 1
        
        button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        button.setTitle(Title.button.rawValue, for: .normal)
        button.backgroundColor = .lightGray
    }
    
    private func bind() {
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    


}

