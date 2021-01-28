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
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTable: UITableView!
    let db = Firestore.firestore()
    
    var messages:[Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        messageTable.dataSource = self
        messageTable.register(UINib(nibName: K.nibName , bundle: nil) , forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
//        if typeMessageTextField.text == "" {
//            sendButton.isEnabled = false
//        }
    }
    
    func loadMessages() {
        
        db.collection("messages").order(by: "time").addSnapshotListener { (querySnapshot, error) in
            self.messages = []
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
                            
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.messageTable.scrollToRow(at: indexPath, at: .top , animated: true)
                        }
                        
                    }
                }
            }
        }
    }
    
    @IBAction func sendButtton(_ sender: UIButton) {
        
        
        if let message = typeMessageTextField.text,
           let sender = Auth.auth().currentUser?.email
//           var date:Double = Date().timeIntervalSince1970
           {
            db.collection("messages").addDocument(data: ["message":message,
                                                         "sender Email":sender,
                                                         "time":Date().timeIntervalSince1970]) { (error) in
                if error != nil {
                    print("error while uploading data...")
                }
            }
        }
        
        typeMessageTextField.text = ""
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
        let message = messages[indexPath.row]
        //var state = true
        if Auth.auth().currentUser?.email == message.senderName {
            //state = false
            cell.messageLabel.text = message.message
            cell.messageLabel.textColor = #colorLiteral(red: 0.302903831, green: 0.435610503, blue: 0.9640749097, alpha: 1)
            cell.messageBubble.backgroundColor = #colorLiteral(red: 1, green: 0.8670093037, blue: 0.8388141605, alpha: 1)
            cell.leftImage.isHidden = true
            
            cell.rightImage.isHidden = false
            cell.rightImage.tintColor = #colorLiteral(red: 0.109066094, green: 0.3351352692, blue: 0.7072570643, alpha: 1)
        }else{
            //state = false
            cell.messageLabel.text = message.message
            cell.messageLabel.textColor = #colorLiteral(red: 0.9832161069, green: 0.5125386472, blue: 0.3935457711, alpha: 1)
            cell.messageBubble.backgroundColor = #colorLiteral(red: 0.8043409634, green: 0.8232862374, blue: 1, alpha: 1)
            cell.leftImage.isHidden = false
            cell.leftImage.tintColor = #colorLiteral(red: 0.9832161069, green: 0.937589354, blue: 0.9500660111, alpha: 1)
            cell.rightImage.isHidden = true
        }
        
        
        
//        let val =  message.message
//        print(val)
        return cell
    }
}

