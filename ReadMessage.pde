class ReadMessage {
  public int MessageID;
  public String SenderName;
  public String RecieverName;
  public String Message;

  public String toString () {
    return String.format("MessageID: %s   SenderName: %s   RecieverName: %s   Message: %s", MessageID, SenderName, RecieverName, Message);
  }
}
