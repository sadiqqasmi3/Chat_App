//
//  LoginViewController.swift
//  Chat_App
//
//  Created by sadiq qasmi on 22/01/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        performSegue(withIdentifier: K.loginIdentifier, sender: nil)
    }
    
   
}

