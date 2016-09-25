//
//  LoginVC.swift
//  TicketBuddy
//
//  Created by Yu-Lin Yang on 9/24/16.
//  Copyright © 2016 Yu-Lin Yang. All rights reserved.
//

import Foundation
import UIKit
import Firebase
public class LoginVC: UIViewController {
    
    @IBOutlet weak var mapImg: UIImageView!
    @IBOutlet weak var btyImg: UIImageView!
    @IBOutlet weak var wrenchImg: UIImageView!
    @IBOutlet weak var cashImg: UIImageView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);

        self.view.backgroundColor = UIColor(red:0.64, green:0.96, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.barTintColor = UIColor(red:0.64, green:0.96, blue:1.00, alpha:1.0)
        mapImg.layer.cornerRadius = 30;
        mapImg.clipsToBounds = true;
        btyImg.layer.cornerRadius = 30;
        btyImg.clipsToBounds = true;
        wrenchImg.layer.cornerRadius = 30;
        wrenchImg.clipsToBounds = true;
        cashImg.layer.cornerRadius = 30;
        cashImg.clipsToBounds = true;
    }
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signIn(_ sender: AnyObject) {
        FIRAuth.auth()?.signIn(withEmail: username.text!, password: password.text!, completion: {
        user, error in
            if error != nil {
                print("Incorrect")
                let alert = UIAlertController(title: "Something went wrong", message: "i don't know how to fix it", preferredStyle: .alert)
                
                
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
            else {
                print("got in")

                self.performSegue(withIdentifier: "success", sender: sender)
                
            }
        })
    }
    override public func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        print("hihihihihihihihi hihih ih i--------------------------------------------")
        //navigationController?.navigationBar.barTintColor = nil;
        
    }
    @IBAction func createAccount(_ sender: AnyObject) {
        FIRAuth.auth()?.createUser(withEmail: username.text!, password: password.text!, completion: {
            user, error in
            print("attempting to create")
            if error != nil {
                self.signIn(self)
            }
            else {
                print("user Created")
                self.signIn(self)
            }
        })
    }
    
    
    
}
