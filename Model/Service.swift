//
//  Service.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 11.01.2023.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Service {
    static let shared = Service()
    
    init() {}
    
    
    func createNewUser(_ data: LoginField, completion: @escaping (ResponceCode) -> ()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password) { [weak self] result, err in
            if err == nil {
                if result != nil {
                    let userID = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email": email]
                    completion(ResponceCode(code: 1))
                    Firestore.firestore().collection("users").document(userID!).setData(data)
                }
            } else {
                completion(ResponceCode(code: 0))
            }
        }
    }
    
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { err in
            if err != nil {
                print(err!.localizedDescription)
            }
        })
    }
    
    func authInApp(_ data: LoginField, completion: @escaping (AuthResponce) -> ()) {
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, err in
            if err != nil {
                completion(.error)
            } else {
                if let result = result {
                    if result.user.isEmailVerified {
                        completion(.success)
                    } else {
                        self.confirmEmail()
                        completion(.noVerify)
                    }
                }
            }
        }
    }
    
    func getUserStatus() {
        
    }
    
    func getAllUsers(completion: @escaping ([CurrentUser]) -> ()) {
        var currentUsers = [CurrentUser]()
        
        guard let email = Auth.auth().currentUser?.email else { return }
        Firestore.firestore().collection("users").whereField("email", isNotEqualTo: email).getDocuments { snap, err in
            if err == nil {
                if let docs = snap?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let userID = doc.documentID
                        let email = data["email"] as! String
                        currentUsers.append(CurrentUser(id: userID, email: email))
                    }
                }
                completion(currentUsers)
            }
        }
    }
    
    //MARK: -- Messenger
    
    func sendMessage(otherID: String?,
                     conversationID: String?,
                     message: Message,
                     text: String,
                     completion: @escaping (Bool)->()) {
        
        if let uid = Auth.auth().currentUser?.uid {
            if  conversationID == nil {
                // create new conversation
            } else {
                let msg: [String: Any] = [
                    "date" : Date(),
                    "sender" : uid,
                    "text" : text
                ]
                Firestore.firestore().collection("conversations").document(conversationID!).collection("messages").addDocument(data: msg) { err in
                    if err == nil {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
        }
        
        
    }
    
    func updateConversation() {
        
    }
    
    func getConverastionID() {
        
    }
    
    func getAllMessages() {
        
    }
    
    func getOneMessage() {
        
    }
    
    func logOut() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
        }
        catch {
            print("Logout failed.")
        }
    }
}
