//
//  Services.swift
//  epIphone
//
//  Created by felix on 13/06/22.
//

import UIKit

class Service{
    static func createAlertController(title:String,message: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok" , style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }
        alert.addAction(okAction)
        
        return alert
    }
}
