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
    
    let bag = DisposeBag()
    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    let nameLabel = UILabel()
    let passwordLabel = UILabel()
    let nameHint = UILabel()
    let passwordHint = UILabel()
    let button = UIButton()
    let minimalLabelLength = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubView()
        
        infoBind()
        tapButton()
        
        nameHint.isHidden = true
        passwordHint.isHidden = true
    }
    
    private func infoBind() {
        
        let usernameValid = nameTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalLabelLength }
            .share(replay: 1)
        
        // 判斷用戶名稱是否有效 -> 有效才能輸入密碼
        usernameValid.bind(to: passwordTextField.rx.isEnabled)
                     .disposed(by: bag)
        
        // 判斷用戶名稱是否有效 -> 用户名提示語是否隱藏
        usernameValid.bind(to: nameHint.rx.isHidden)
                     .disposed(by: bag)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= self.minimalLabelLength }
            .share(replay: 1)
        
        // 判斷密碼是否有效 -> 密碼提示語是否隱藏
        passwordValid.bind(to: passwordHint.rx.isHidden)
                     .disposed(by: bag)
        
        let infoValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 } // 用戶名跟密碼同時有效
                                 .share(replay: 1)
        
        // 判斷資訊是否有效 -> 有效才能點擊按鈕
        // infoValid.bind(to: button.rx.isEnabled)
        //          .disposed(by: bag)
        
        // 按鈕狀態與顏色設定
        infoValid.bind { [weak self] enable in
            self?.button.isEnabled = enable
            self?.button.backgroundColor = enable ? UIColor.green : UIColor.red
        }
        .disposed(by: bag)
    }
    
    private func tapButton() {
        
        button.rx.tap.subscribe(onNext: { [weak self] in self?.configureAlert() })
                     .disposed(by: bag)
    }
    
    private func configureAlert() {
        
        let alert = UIAlertController(
            title: "Hello RxSwift",
            message: "You did it well!",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // 建立UI
    private func setUpSubView() {
        
        [nameLabel, nameTextField, nameHint, passwordLabel, passwordTextField, passwordHint,  button].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        }
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        nameLabel.text = Title.name.rawValue
        
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.layer.borderWidth = 1
        
        nameHint.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        nameHint.text = "Username has to be at least \(minimalLabelLength) characters"
        nameHint.textColor = .red
//        nameHint.isHidden = true
        
        passwordLabel.topAnchor.constraint(equalTo: nameHint.bottomAnchor, constant: 40).isActive = true
        passwordLabel.text = Title.password.rawValue
        
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.borderWidth = 1
        
        passwordHint.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        passwordHint.text = "Password has to be at least \(minimalLabelLength) characters"
        passwordHint.textColor = .red
//        passwordHint.isHidden = true
        
        button.topAnchor.constraint(equalTo: passwordHint.bottomAnchor, constant: 40).isActive = true
        button.setTitle(Title.button.rawValue, for: .normal)
    }
}
