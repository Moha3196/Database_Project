public boolean CheckLogIn(String usernameInput, String passwordInput) {

  db.query("SELECT * FROM Users WHERE Username = '%s'", usernameInput);

  while (db.next()) {
    TableOne t = new TableOne();
    db.setFromRow( t );
    
    if (t.Username.equals(usernameInput) && t.Password.equals(passwordInput)) { 
      return true;
    }
  }
  
  return false;
}
