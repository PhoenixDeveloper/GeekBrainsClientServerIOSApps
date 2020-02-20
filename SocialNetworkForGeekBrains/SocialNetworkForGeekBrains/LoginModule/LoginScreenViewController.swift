//
//  LoginScreenViewController.swift
//  SocialNetworkForGeekBrains
//
//  Created by Михаил Беленко on 20.02.2020.
//  Copyright © 2020 Михаил Беленко. All rights reserved.
//

import UIKit
import RxSwift

class LoginScreenViewController: UIViewController {

    var disposeBag = DisposeBag()

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginTextField.tag = 0
        passwordTextField.tag = 1

        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func moveToApp() {}

    @IBAction func clickAcceptButton(_ sender: UIButton) {
        moveToApp()
    }
}

extension LoginScreenViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passwordTextField.becomeFirstResponder()
        case 1:
            moveToApp()
        default:
            fatalError("Need add textFields tags")
        }
        return false
    }
}
