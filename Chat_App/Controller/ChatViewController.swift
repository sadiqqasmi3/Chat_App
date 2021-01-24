//
//  ChatViewController.swift
//  Chat_App
//
//  Created by sadiq qasmi on 22/01/2021.
//

import UIKit


class ChatViewController: UIViewController {

    @IBOutlet weak var typeMessageTextField: UITextField!
    @IBOutlet weak var messageTable: UITableView!
    let messages = [Message(senderName: "me", message: "hi"),
                    Message(senderName: "me", message: "hello"),
                    Message(senderName: "me", message: "testing cjkndskjcnkdsn cbkjdsckjsdnc udhskchsuidkc buihsdcknka"),
                    Message(senderName: "me", message: "testing 1")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTable.dataSource = self
        messageTable.register(UINib(nibName: K.nibName , bundle: nil) , forCellReuseIdentifier: K.cellIdentifier)
    }
    @IBAction func sendButtton(_ sender: UIButton) {
    }
    
    @IBAction func LogoutButton(_ sender: UIBarButtonItem) {
    }

}
 
extension ChatViewController:UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTable.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageViewCell
        cell.messageLabel.text = messages[indexPath.row].message
        return cell
        
        
        
    }
    
    
}

