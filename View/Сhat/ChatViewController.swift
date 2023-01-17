//
//  ChatViewController.swift
//  SimpleChat
//
//  Created by Станислав Шульц on 17.01.2023.
//

import UIKit
import MessageKit

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
    
    var chatID: String?
    let selfSender = Sender(senderId: "1", displayName: "Me")
    let otherSender = Sender(senderId: "2", displayName: "Jony")

    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date().addingTimeInterval(-12200), kind: .text("Hey")))
        messages.append(Message(sender: selfSender, messageId: "2", sentDate: Date().addingTimeInterval(-11200), kind: .text("Hello")))
        messages.append(Message(sender: otherSender, messageId: "3", sentDate: Date().addingTimeInterval(-10200), kind: .text("Hello, im fine")))
        
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        showMessageTimestampOnSwipeLeft = true
        
        print(messages)
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
