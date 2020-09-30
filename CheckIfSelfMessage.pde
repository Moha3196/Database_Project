
public boolean CheckIfSelfMessage(String usernameInput) {

  db.query("SELECT * FROM Users WHERE Username = '%s'", usernameInput);

  while (db.next()) {

    db.setFromRow(recieveUser);

    if (recieveUser.Username.equals(usernameInput)) {
      if (user.Username.equals(usernameInput)) {
        isMessageProceedButtonHighlighted = false;
        isMessageHighlighted = false;
        isRecieverHighlighted = true;
        println("FAILED TO SEND MESSAGE");
        
        // Shows a message dialog for when user input is incorrect.
        showMessageDialog(null, "You cant send a message to yourself", "Error in Message", ERROR_MESSAGE);
        return false;
      } else {
        println("AAAAAAAAAAAAA");
        return true;
      }
    }
  }

  return true;
}
