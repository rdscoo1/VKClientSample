//
//  ViewController.swift
//  VKClientSample
//
//  Created by Roman Khodukin on 23.12.2019.
//  Copyright © 2019 Roman Khodukin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    let secureTextEntryButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setupActionHideKeyboard()
        correctCredentials()
        showPassword()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setUI() {
        loginButton.backgroundColor = UIColor(hex: "#466e9c", alpha: 0.5)
        loginButton.layer.cornerRadius = 10
        
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    func showPassword() {
        secureTextEntryButton.setImage(.eye, for: .normal)
        secureTextEntryButton.tintColor = .gray
        secureTextEntryButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        secureTextEntryButton.frame = CGRect(x: 0, y: 0, width: 22, height: 16)
        secureTextEntryButton.addTarget(self, action: #selector(showPasswordTapped), for: .touchUpInside)
        passwordTF.rightView = secureTextEntryButton
        passwordTF.rightViewMode = .always
    }
    
    @objc func showPasswordTapped() {
        if passwordTF.isSecureTextEntry == true {
            passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
            UIView.animate(withDuration: 0.4, animations: {
                self.secureTextEntryButton.setImage(.hidePassword, for: .normal)
            })
        } else {
            passwordTF.isSecureTextEntry = !passwordTF.isSecureTextEntry
            UIView.animate(withDuration: 0.4, animations: {
                self.secureTextEntryButton.setImage(.eye, for: .normal)
            })
        }
    }
    
    private func setupActionHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func correctCredentials() {
        emailTF.text = "admin"
        passwordTF.text = "12345"
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let email = emailTF.text!
        let password = passwordTF.text!
        
        if email == "admin" && password == "12345" {
            view.endEditing(true)
            return true
        } else {
            let alertVC = UIAlertController(title: "❌User or password is incorrect❌", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Try again", style: .cancel, handler: nil)
            alertVC.addAction(alertAction)
            present(alertVC, animated: true, completion: nil)
            return false
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Show/Hide keyboard
extension LoginViewController {
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
