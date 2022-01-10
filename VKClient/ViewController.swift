//
//  ViewController.swift
//  VKClient
//
//  Created by Вадим Ахмаров on 09.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textFieldLogin: UITextField!
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    @IBAction func onButtonLoginTouchUpInside(_ sender: Any) {
        print("Login: " + (textFieldLogin.text ?? "<null>"))
        print("Password: " + (textFieldPassword.text ?? "<null>"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onKeyboradShown),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.onKeyboardHidden),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    @objc func onKeyboradShown(notification: Notification) {
        guard let info = notification.userInfo else {
            return
        }
        let kbSize = ((info as NSDictionary).value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height * 3, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func onKeyboardHidden(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    @objc func hideKeyBoard() {
        scrollView.endEditing(true)
    }
}

