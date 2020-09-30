public boolean CheckLogIn(String usernameInput, String passwordInput) {
  //passwordInput = Encryption(passwordInput);

  db.query("SELECT * FROM Users WHERE Username = '%s'", usernameInput);

  while (db.next()) {

    db.setFromRow(user);
    //user.Password = Encryption(user.Password);
    //println(user.Password);
    if (user.Username.equals(usernameInput) && user.Password.equals(passwordInput)) {        
      return true;
    }
  }

  return false;
}


public String Encryption (String pw) {
  for (int i = 0; i <= alphabetCharCount.length-1; i++) {
    alphabetCharCount[i] = alphabet.charAt(i);
    //println(alphabetCharCount[i]);
  }
  
  for (int i = 0; i <= pw.length()-1; i++) {
    for (int ii = 0; ii <= alphabetCharCount.length-1; ii++) {
      if (pw.charAt(i) == alphabetCharCount[ii]) {
        iii = ii + letterShift;

        if (iii > 50) {
          iii -= 50;
        }
        //println(password.charAt(i) + "=" + iii);
        encryptedPassword = encryptedPassword + alphabetCharCount[iii];
      }
    }
  }
  
  return encryptedPassword;
}
