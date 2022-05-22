//
//  RegisterController.swift
//  epIphone
//
//  Created by felix on 15/05/22.
//

import UIKit

class RegisterController: UIViewController{
    
    
    
    @IBOutlet private weak var viewConten: UIView!
    @IBOutlet private weak var centerContentY: NSLayoutConstraint!
    
    @IBAction private func tapTopCloseKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @IBOutlet private weak var nameField: UITextField!
    
    @IBOutlet private weak var apellidoField: UITextField!
    
    @IBOutlet private weak var emailField: UITextField!
    
    @IBOutlet private weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        nameField.layer.borderWidth =  1
        nameField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nameField.layer.cornerRadius = 20
        nameField.layer.masksToBounds = true
        
        apellidoField.layer.borderWidth =  1
        apellidoField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        apellidoField.layer.cornerRadius = 20
        apellidoField.layer.masksToBounds = true
        
        emailField.layer.borderWidth =  1
        emailField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailField.layer.cornerRadius = 20
        emailField.layer.masksToBounds = true
        
        passwordField.layer.borderWidth =  1
        passwordField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordField.layer.cornerRadius = 20
        passwordField.layer.masksToBounds = true    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unRegisterKeyboardNotication()
    }
    
    private func registerKeyboardNotification(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(Self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(Self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
        
    }
    
    @objc private func keyboardWillShow(_ notification: Notification){
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double ?? 0
        let keybordFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        
        if keybordFrame.origin.y  < self.viewConten.frame.maxY {
            UIView.animate(withDuration: animationDuration){
                self.centerContentY.constant = keybordFrame.origin.y - self.viewConten.frame.maxY
                self.view.layoutIfNeeded()
            }
        }
            
    }
    
    @objc private func keyboardWillHide(_ notification: Notification){
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        UIView.animate(withDuration: animationDuration){
            self.centerContentY.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    
    private func unRegisterKeyboardNotication(){
        NotificationCenter.default.removeObserver(self)
       
    }}
