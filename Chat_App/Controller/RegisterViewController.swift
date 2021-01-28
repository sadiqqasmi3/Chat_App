//
//  RegisterViewController.swift
//  Chat_App
//
//  Created by sadiq qasmi on 22/01/2021.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var createEmailField: UITextField!
    @IBOutlet weak var createPassField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func registerButton(_ sender: UIButton) {
        if let email = createEmailField.text, let password = createPassField.text {
            print(email)
            print(password)
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error != nil{
                    print(error!.localizedDescription)
                    
                }else{
                    self.performSegue(withIdentifier: K.registerIdentifier, sender: nil)
                }
            }
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
