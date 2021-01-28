//
//  ChatViewController.swift
//  Chat_App
//
//  Created by sadiq qasmi on 22/01/2021.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class ChatViewController: UIViewController {

    @IBOutlet weak var typeMessageTextField: UITextField!
    @IBOutlet weak var messageTable: UITableView!
    let db = Firestore.firestore()
    
    var messages:[Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        messageTable.dataSource = self
        messageTable.register(UINib(nibName: K.nibName , bundle: nil) , forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    func loadMessages() {
        messages = []
        db.collection("messages").addSnapshotListener { (querySnapshot, error) in
            if let snapshotDocument = querySnapshot?.documents{
                for doc in snapshotDocument {
                    let newMessage = doc.data()
                    //print(doc.data())
                    //print(newMessage["message"]!)
                   if let messageSender = newMessage["sender Email"] as? String,
                      let messageBody = newMessage["message"] as? String {
                    let message = Message(senderName: messageSender, message: messageBody)
                    self.messages.append(message)
                    DispatchQueue.main.async {
                        self.messageTable.reloadData()
                    }
                    
                   }
                }
            }
        }
    }
    
    @IBAction func sendButtton(_ sender: UIButton) {
        if let message = typeMessageTextField.text,
           let sender = Auth.auth().currentUser?.email{
            db.collection("messages").addDocument(data: ["message":message,
                                                         "sender Email":sender]) { (error) in
                if error != nil {
                    print("error while uploading data...")
                }
            }
        }
    }
    
    @IBAction func LogoutButton(_ sender: UIBarButtonItem) {
        do{
        try Auth.auth().signOut()
        navigationController?.popToRootViewController(animated: true)
        
        }catch{
            print("error")
        }
    }
}
 
extension ChatViewController:UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTable.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageViewCell
        cell.messageLabel.text = messages[indexPath.row].message
        let val =  messages[indexPath.row].message
        print(val)
        return cell
    }
}

