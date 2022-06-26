//
//  RegisterController.swift
//  epIphone
//
//  Created by felix on 15/05/22.
//

import UIKit
import FirebaseAuth
import Firebase


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
    
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)    }
    
    
    @IBAction func InView(_ sender: Any) {
        
        let LoginController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.LoginController) as? LoginController
        
        view.window?.rootViewController = LoginController
        view.window?.makeKeyAndVisible()
    }
    @IBOutlet weak var singUpButton: UIButton!
    
    
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
    func validateField() -> String? {
        if nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            apellidoField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill all field"
        }
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if   Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least is at least 8 characters ,contains a special contains a special character and a nomber"
        }
        
        return nil
    }
 
    @IBAction func buttonSignUp(_ sender: Any) {
        
        let error = validateField()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = apellidoField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
                
            }
            
            
            
        }
    }
    
    func showError(_ message:String) {
        
    }
    
    func transitionToHome() {
        
        let ContactsController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.ContactsController) as? ContactsController
        
        view.window?.rootViewController = ContactsController
        view.window?.makeKeyAndVisible()
        
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
       
    }}
