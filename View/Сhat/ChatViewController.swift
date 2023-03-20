//
//  ChatViewController.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 17.01.2023.
//

import UIKit
import MessageKit
import InputBarAccessoryView

public struct Sender: SenderType {
    public var senderId: String
    public var displayName: String
}

public struct Message: MessageType {
    public var sender: MessageKit.SenderType
    public var messageId: String
    public var sentDate: Date
    public var kind: MessageKit.MessageKind
}


class ChatViewController: MessagesViewController {
    
    var otherID: String?
    var chatID: String?
    let selfSender = Sender(senderId: "1", displayName: "Me")
    let otherSender = Sender(senderId: "2", displayName: "Jony")
    let service = Service.shared
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        showMessageTimestampOnSwipeLeft = true
        loadFirstMessages()
    }
    
    func loadFirstMessages() {
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem(animated: false)
        }
    }
    
}



extension ChatViewController: MessagesDataSource {
    
    var currentSender: MessageKit.SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}

extension ChatViewController: MessagesLayoutDelegate, MessagesDisplayDelegate { }

extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = Message(sender: selfSender, messageId: "", sentDate: Date(), kind: .text(text))
        messages.append(message)
        service.sendMessage(otherID: self.otherID,
                            conversationID: self.chatID,
                            message: message,
                            text: text) {
            [weak self] isSend in
            
            DispatchQueue.main.async {
                inputBar.inputTextView.text = nil
                self?.messagesCollectionView.reloadDataAndKeepOffset()
            }
        }
        
    }
}
