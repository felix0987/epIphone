//
//  ContactsController.swift
//  epIphone
//
//  Created by felix on 25/06/22.
//

import UIKit

class ContactsController : UIViewController {
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
}
