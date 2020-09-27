

void SendMessageToDB(User senderUser, User recieverUser, String messageContent) {
  db.query("INSERT INTO Messages (SenderID, RecieverID, Message) VALUES ('%s', '%s', '%s')", senderUser.UserID, recieverUser.UserID, messageContent); 
}



public ArrayList<ReadMessage> LoadMessagesFromDB() {
  
  ArrayList<ReadMessage> messagesArray = new ArrayList<ReadMessage>();
  // Original query: SELECT messages.MessageID,senderUser.Username'SenderName',recieverUser.Username'RecieverName',messages.Message FROM Messages messages LEFT JOIN Users senderUser ON messages.SenderID=senderUser.UserID LEFT JOIN Users recieverUser ON messages.RecieverID=recieverUser.UserID;
  db.query("SELECT * FROM ReadableMessagesView;");

  while (db.next()) {
    ReadMessage readMessage = new ReadMessage();
    db.setFromRow(readMessage);    
    messagesArray.add(readMessage);
  }

  return messagesArray;
}
