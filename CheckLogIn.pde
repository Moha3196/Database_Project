public boolean CheckLogIn(String usernameInput, String passwordInput) {

  db.query("SELECT * FROM Users WHERE Username = '%s'", usernameInput);
  
  while (db.next()) {
    
    db.setFromRow(user);
    
    if (user.Username.equals(usernameInput) && user.Password.equals(passwordInput)) {  
      return true;
    }
  }
  
  return false;
}
