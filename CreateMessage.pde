class CreateMessage {
  public int MessageID;
  public int SenderID;
  public int RecieverID;
  public String Message;

  public String toString () {
    return String.format("MessageID: %s   SenderID: %s   RecieverID: %s   Message: %s", MessageID, SenderID, RecieverID, Message);
  }
}
