//
//  LoginViewController.swift
//  Chat_App
//
//  Created by sadiq qasmi on 22/01/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text{
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: K.loginIdentifier, sender: nil)
                }
                
            }
        }
    }
}
