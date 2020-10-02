public boolean CheckLogIn(String usernameInput, String passwordInput) {
  passwordInput = encryptMessage(messageInput);

  db.query("SELECT * FROM Users WHERE Username = '%s'", usernameInput);


  while (db.next()) {

    db.setFromRow(user);
    println(user.Username.equals(usernameInput), user.Password.equals(passwordInput));
    if (user.Username.equals(usernameInput) && user.Password.equals(passwordInput)) {
      return true;
    }
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


public String encryptPassword(String pw) {
  //Ofte "hashe's" passwords inden de gemmes i en database, så de ikke kan læses direkte af en hacker.
  //
  //Video om emnet:  "Hashing Algorithms and Security - Computerphile"
  //youtube-link:    https://youtu.be/b4b8ktEV4Bg

  

  try {
    //Vha. MessageDigest kan vi anvende en hashing algoritme.... her SHA-256 ...
    //prøv f.eks. MD-5 og se om du kan bryde den ved at søge på nettet!
    MessageDigest md = MessageDigest.getInstance("SHA-256"); 

    //Input er en tekst der skal "hashes"
    //String inputTekst="aabbccddeeff";

    //MassageDigest objektet "fodres" med teksten, der skal "hashes"
    md.update(password.getBytes());    

    //digest funktionen giver "hash-værdien", men i hexadecimale bytes 
    byte[] byteList = md.digest();

    //Her anvendes processings hex funktion, der kan konvertere hexadecimale bytes til Strings
    //så det er muligt at læse "hash-værdien"
    StringBuffer hashedValueBuffer = new StringBuffer();
    for (byte b : byteList)hashedValueBuffer.append(hex(b)); 

    //Her udskrives den oprindelige tekst
    println("Den orindelige tekst: "+ password);
    //Her udskrives "hash-værdien" af teksten
    println("SHA-256 værdien af teksten: " +hashedValueBuffer.toString());
    encryptedPassword = hashedValueBuffer.toString();
    
    return encryptedPassword;
  }
  catch (Exception e) {
    System.out.println("Exception: "+e);
  }
  return pw;
}


public String encryptMessage(String ms) {
  for (int i = 0; i <= alphabetCharCount.length-1; i++) {
    alphabetCharCount[i] = alphabet.charAt(i);
    //println(alphabetCharCount[i]);
  }

  for (int i = 0; i <= ms.length()-1; i++) {
    for (int ii = 0; ii <= alphabetCharCount.length-1; ii++) {
      if (ms.charAt(i) == alphabetCharCount[ii]) {
        iii = ii + letterShift;

        if (iii > 50) {
          iii -= 50;
        }
        //println(password.charAt(i) + "=" + iii);
        encryptedMessage = encryptedMessage + alphabetCharCount[iii];
      }
    }
  }
  return encryptedMessage;
}
