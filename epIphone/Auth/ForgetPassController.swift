//
//  ForgetPassController.swift
//  epIphone
//
//  Created by felix on 15/05/22.
//

import UIKit
import Firebase
class ForgetPassController: UIViewController {
    
    @IBOutlet private weak var viewConten: UIView!
    @IBOutlet private weak var centerContentY: NSLayoutConstraint!
    
    @IBAction private func tapTopCloseKeyboard(_ sender:UITapGestureRecognizer){
        
        self.view.endEditing(true)
        
    }
    
    
    
    
    @IBAction func buttonBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)    }
    
   
    @IBOutlet private weak var emailField: UITextField!
    
    
    @IBAction func forget(_ sender: UIButton) {
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailField.text!) { (error) in
            if let error = error {
              let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
              self.present(alert, animated: true , completion: nil)
              return
           }
              let alert = Service.createAlertController(title: "Email validado", message: "se envio un correo para cambiar de contraseña")
              self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
       override func viewDidLoad() {
       super.viewDidLoad()
           emailField.layer.borderWidth =  1
           emailField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           emailField.layer.cornerRadius = 20
           emailField.layer.masksToBounds = true
           
        
    }
    
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
