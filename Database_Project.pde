
/*keyCode = 157 For Mac CMD/Command*/
/*keyCode = 20 For Capslock*/
/*keyCode = 0 For FN*/
import static javax.swing.JOptionPane.*;
import de.bezier.data.sql.*;
SQLite db;
ArrayList<User> contactListArray = new ArrayList<User>();
//int time = 0;
int screen = 1;
String username = ""; 
String password = ""; 
String messageInput = "";
String recieverInput = "";
String viewMessage = ""; 
String encryptedPassword = "";
String alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
char[] alphabetCharCount = new char[50+1];
int letterShift = 4;
int iii;
int amountMessagesShown  = 0;
boolean isPasswordHighlighted, isProceedButtonHighlighted, isSignUpButtonHighlighted, isDropdownListPressed = false; 
boolean isViewMessageProceedButtonHighlighted, isMessageProceedButtonHighlighted, isMessageHighlighted = false;
boolean isUsernameHighlighted = true, isRecieverHighlighted = true;
PFont font;
PFont font1;
PFont font2;
User user = new User();
User recieveUser = new User(); 



void setup() {
  size(1000, 600);

  db = new SQLite( this, "SQLite Database-projekt.db" );  // open database file
}



void draw() {
  //Changes the screens
  if (screen == 1) {
    LogIn();
  }

  if (screen == 2) {
    ViewMessagesScreen();
    
  }

  if (screen == 3) {
    SendMessageScreen();
  }
}



void keyPressed() {
  final int k = keyCode;

  if (screen == 1) {
    //Username
    if (isUsernameHighlighted && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
      && k != 0 && k != UP && k != LEFT && k != DOWN && k != RIGHT && k != 157 && k != 20 && username.length() <= 18) {
      username += key;
    }

    if (isUsernameHighlighted && k == BACKSPACE) {
      try {
        username = username.substring(0, username.length()-1);
      }
      catch(Exception e) {
      }
    }

    //Password
    if (isPasswordHighlighted && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
      && k != 0 && k != UP && k != LEFT && k != DOWN && k != RIGHT && k != 157 && k != 20 && password.length() <= 18) {
      password += key;
      //println(password);
    }

    if (isPasswordHighlighted && k == BACKSPACE) {
      try {
        password = password.substring(0, password.length()-1);
      }
      catch(Exception e) {
      }
    }

    if (k == ENTER && isProceedButtonHighlighted) {
      // If there is connection to database, proceed with checking user input.
      if (db.connect()) {
        if (CheckLogIn(username, password)) {
          // If CheckLogIn returns true in case of correct user input, the program navigates to next screen.
          showMessageDialog(null, "You have successfully logged in!", "Login Succes", INFORMATION_MESSAGE);
          screen = 2;
          isProceedButtonHighlighted = false;
          isPasswordHighlighted = false;
          isUsernameHighlighted = true;
          contactListArray = LoadContactListFromDB();


          //println(password);
          //println(contactListArray);
          //time = millis();
        } else {
          println("FAILED LOG-IN");
          // Shows a message dialog for when user input is incorrect.
          showMessageDialog(null, "The provided login credentials are not correct!", "Login error", ERROR_MESSAGE);
        }
      }
    }
  }


  if (screen == 3) {
    //Reciever
    if (isRecieverHighlighted && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
      && k != 0 && k != UP && k != LEFT && k != DOWN && k != RIGHT && k != 157 && k != 20 && recieverInput.length() <= 18) {
      recieverInput += key;
    }

    if (isRecieverHighlighted && k == BACKSPACE) {
      try {
        recieverInput = recieverInput.substring(0, recieverInput.length()-1);
      }
      catch(Exception e) {
      }
    }

    //Message
    if (isMessageHighlighted && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
      && k != 0 && k != UP && k != LEFT && k != DOWN && k != RIGHT && k != 157 && k != 20 && messageInput.length() <= 200) {
      messageInput += key;
    }
    if (isMessageHighlighted && k == ENTER) {
      messageInput += "\n";
    }
    if (isMessageHighlighted && k == BACKSPACE) {
      try {
        messageInput = messageInput.substring(0, messageInput.length()-1);
      }
      catch(Exception e) {
      }
    }

    //Show Dropdown
    if (k == ENTER && isRecieverHighlighted) {
      isRecieverHighlighted = false;
      isDropdownListPressed = true;
    }
  }
}

void keyReleased() {
  final int k = keyCode;
  if (screen == 1) {
    if (k == TAB && isProceedButtonHighlighted) {
      //Switch to Username 
      isUsernameHighlighted = true;
      isPasswordHighlighted = false;
      isSignUpButtonHighlighted = false;
      isProceedButtonHighlighted = false;
    } else if (k == TAB && isUsernameHighlighted) { 
      //Switch to Password 
      isUsernameHighlighted = false;
      isPasswordHighlighted = true;
      isSignUpButtonHighlighted = false;
      isProceedButtonHighlighted = false;
    } else if (k == TAB && isPasswordHighlighted) {
      //Switch to Username 
      isUsernameHighlighted = false;
      isPasswordHighlighted = false;
      isSignUpButtonHighlighted = true;
      isProceedButtonHighlighted = false;
    } else if (k == TAB && isSignUpButtonHighlighted) {
      //Switch to Proceed Button 
      isUsernameHighlighted = false;
      isPasswordHighlighted = false;
      isSignUpButtonHighlighted = false;
      isProceedButtonHighlighted = true;
    } 

    if (k == ENTER && isSignUpButtonHighlighted) {
      if (db.connect()) {
        if (CheckCreatedUsername(username)) {
          //Switch to Proceed Button 
          isUsernameHighlighted = true;
          isPasswordHighlighted = false;
          isSignUpButtonHighlighted = false;
          isProceedButtonHighlighted = false;
          password = Encryption(password);
          CreateUser(username, password);
          username = "";
          password = "";
        }
      }
    }
  }

  if (screen == 2) {

    if (k == TAB && isViewMessageProceedButtonHighlighted == false) {
      isViewMessageProceedButtonHighlighted = true;
    } else if (k == TAB && isViewMessageProceedButtonHighlighted == true) {
      isViewMessageProceedButtonHighlighted = false;
    } else if (k == ENTER && isViewMessageProceedButtonHighlighted) {
      isViewMessageProceedButtonHighlighted = false;
      screen = 3;
    }
  }

  if (screen == 3) {
    if (k == TAB && isMessageProceedButtonHighlighted) {
      //Switch to Username
      isMessageProceedButtonHighlighted = false;
      isRecieverHighlighted = true;
    } else if ((k == TAB && isRecieverHighlighted)) {
      //Switch to Message
      isRecieverHighlighted = false;
      isMessageHighlighted = true;
    } else if (k == TAB && isMessageHighlighted) {
      //Switch to Proceed Button
      isMessageHighlighted = false;
      isMessageProceedButtonHighlighted = true;
    }

    //Send Message
    if (k == ENTER && isMessageProceedButtonHighlighted) {
      if (db.connect()) {
        if (CheckReciever(recieverInput)) {
          // If CheckLogIn returns true in case of correct user input, the program navigates to next screen.
          showMessageDialog(null, "Your message has been successfully delivered!", "Message Sent", INFORMATION_MESSAGE);
          SendMessageToDB(user, recieveUser, messageInput);
          screen = 2;
          viewMessage = "";
          messageInput = "";
          recieverInput = "";
          isMessageHighlighted = false;
          isMessageProceedButtonHighlighted = false;
          isRecieverHighlighted = true;
          //time = millis();
          amountMessagesShown = 0;
        }
      }
    }
  }
}


void mousePressed() {
  if (screen == 1) {
    if (mouseX >= width/4 && mouseX <= width/4*3 && mouseY >= height/3-50 && mouseY <= height/3-20) {
      //Switch to Username 
      isProceedButtonHighlighted = false;
      isPasswordHighlighted = false;
      isUsernameHighlighted = true;
    } else if (mouseX >= width/4 && mouseX <= width/4*3 && mouseY >= height/3-12.5 && mouseY <= height/3+17.5) { 
      //Switch to Password 
      isUsernameHighlighted = false;
      isPasswordHighlighted = true;
      isProceedButtonHighlighted = false;
    } else if (mouseX >= width/4*3-70 && mouseX <= width/4*3+70 && mouseY >= height/3*2 && mouseY <= height/3*2 + 30) {
      //Switch to Proceed Button 
      isProceedButtonHighlighted = true;
      isPasswordHighlighted = false;
      isUsernameHighlighted = false;
    }
  }

  if (screen == 3) {
    if (mouseX >= width/4 && mouseX <= width/4*3 && mouseY >= height/4-50 && mouseY <= height/4-20 && isDropdownListPressed == false) {
      //Switch to Username 
      isMessageProceedButtonHighlighted = false;
      isMessageHighlighted = false;
      isRecieverHighlighted = true;
    } else if (mouseX >= width/4 && mouseX <= width/4*3 && mouseY >= height/4+17.5 && mouseY <= height/12*11-32.5 && isDropdownListPressed == false) {
      //Switch to Message 
      isRecieverHighlighted = false;
      isMessageHighlighted = true;
      isMessageProceedButtonHighlighted = false;
    } else if (mouseX >= width/4*3-60 && mouseX <= width/4*3+60 && mouseY >= height-50 && mouseY <= height-20 && isDropdownListPressed == false) {
      //Switch to Proceed Button  
      isMessageHighlighted = false;
      isRecieverHighlighted = false;
      isMessageProceedButtonHighlighted = true;
    }
  }
}
