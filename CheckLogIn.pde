public boolean CheckLogIn(String usernameInput, String passwordInput) {
  passwordInput = Encryption(passwordInput);

  db.query("SELECT * FROM Users WHERE Username = '%s'", usernameInput);
  
  
    while (db.next()) {
    
    db.setFromRow(user);
    println(user.Username.equals(usernameInput), user.Password.equals(passwordInput));
    if (user.Username.equals(usernameInput) && user.Password.equals(passwordInput)) {
      return true;
    } 
    /*if (user.Password.equals(passwordInput) &&  user.Username.equals("0")) {
      println("FAILED LOG-IN");
      // Shows a message dialog for when user input is incorrect.
      showMessageDialog(null, "The provided login credentials are not correct!", "Login error", ERROR_MESSAGE);
      return false;
    } else if (user.Username.equals(usernameInput) &! user.Password.equals(passwordInput)) {
      println("FAILED LOG-IN");
      // Shows a message dialog for when user input is incorrect.
      showMessageDialog(null, "The provided login credentials are not correct!", "Login error", ERROR_MESSAGE);
      return false;
    }
    */
  }

  return false;
}

public boolean CheckCreatedUsername(String usernameInput) {

  db.query("SELECT * FROM Users WHERE Username = '%s'", usernameInput);

  while (db.next()) {

    db.setFromRow(user);
    //user.Password = Encryption(user.Password);
    //println(user.Password);
    if (user.Username.equals(usernameInput)) {
      isUsernameHighlighted = true;
      isPasswordHighlighted = false;
      isSignUpButtonHighlighted = false;
      isProceedButtonHighlighted = false;
      println("FAILED SIGN-UP");
      // Shows a message dialog for when user is already created.
      showMessageDialog(null, "The provided username already exists, please choose a new username!", "Sign Up error", ERROR_MESSAGE);
      return false;
    }
  }

  return true;
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
