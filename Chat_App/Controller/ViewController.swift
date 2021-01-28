//
//  ViewController.swift
//  Chat_App
//
//  Created by sadiq qasmi on 22/01/2021.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {

    @IBOutlet var titalLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titalLabel.text = K.appName
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }


}

