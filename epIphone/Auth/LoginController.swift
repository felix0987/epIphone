//
//  LoginController.swift
//  epIphone
//
//  Created by felix on 15/05/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth




class LoginController: UIViewController{

    @IBOutlet private weak var viewConten: UIView!
    @IBOutlet private weak var centerContentY: NSLayoutConstraint!
    
    @IBAction private func tapTopCloseKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    @IBOutlet private weak var passwordField: UITextField!
    
    @IBOutlet private weak var emailField: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.layer.borderWidth =  1
        emailField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailField.layer.cornerRadius = 20
        emailField.layer.masksToBounds = true
        
        passwordField.layer.borderWidth =  1
        passwordField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordField.layer.cornerRadius = 20
        passwordField.layer.masksToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unRegisterKeyboardNotication()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        // TODO: Validate Text Fields
        
        // Create cleaned versions of the text field
        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                
            }
            else {
                
                let ContactsController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.ContactsController) as? ContactsController
                
                self.view.window?.rootViewController = ContactsController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    
    
    private func registerKeyboardNotification(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(Self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(Self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
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
       
    }
    
    
}
