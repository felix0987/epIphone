//
//  ForgetPassController.swift
//  epIphone
//
//  Created by felix on 15/05/22.
//

import UIKit
class ForgetPassController: UIViewController {
    
    @IBOutlet private weak var viewConten: UIView!
    @IBOutlet private weak var centerContentY: NSLayoutConstraint!
    
    @IBAction private func tapTopCloseKeyboard(_ sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
       override func viewDidLoad() {
       super.viewDidLoad()
        
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
