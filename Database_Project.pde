
/*keyCode = 157 For Mac CMD/Command*/
/*keyCode = 20 For Capslock*/
/*keyCode = 0 For FN*/
import static javax.swing.JOptionPane.*;
import de.bezier.data.sql.*;
SQLite db;
int screen = 1;
String username = ""; 
String password = ""; 
String messageInput = "";
String recieverInput = "";
boolean isUsernameFinished, isPasswordFinished, isProceedButtonHighlighted = false; 
boolean isMessageProceedButtonHighlighted, isMessageFinished = false;
boolean isRecieverFinished = true;
PFont font;
User user = new User();


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
    SendMessageScreen();
  }
}



void keyPressed() {
  final int k = keyCode;
  if (screen == 1) {
    //Username
    if (!isUsernameFinished && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
      && k != 0 && k != UP && k != LEFT && k != DOWN && k != RIGHT && k != 157 && k != 20 && username.length() <= 18) {
      username += key;
    }

    if (!isUsernameFinished && k == BACKSPACE) {
      try {
        username = username.substring(0, username.length()-1);
      }
      catch(Exception e) {
      }
    }

    //Password
    if (isPasswordFinished && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
      && k != 0 && k != UP && k != LEFT && k != DOWN && k != RIGHT && k != 157 && k != 20 && password.length() <= 18) {
      password += key;
      //println(password);
    }

    if (isPasswordFinished && k == BACKSPACE) {
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
          //println("You have successfully logged in!");
          screen = 2;
          //User recieveUser = new User(); 
          //recieveUser.UserID = 2;
          //SendMessageToDB(user, recieveUser, messageInput);

          println("Loading messages from database... \n");
          for (ReadMessage message : LoadMessagesFromDB()) {
            //println(message.SenderName);
            //println(message.RecieverName);
            println(message.SenderName + " -> " + message.RecieverName);
            println(message.Message);
            println("");
          }
        } else {
          println("FAILED LOG-IN");
          // Shows a message dialog for when user input is incorrect.
          showMessageDialog(null, "The provided login credentials are not correct!", "Login error", ERROR_MESSAGE);
        }
      }
    }
  }  

  if (screen == 2) {
    //Reciever
    if (isRecieverFinished && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
      && k != 0 && k != UP && k != LEFT && k != DOWN && k != RIGHT && k != 157 && k != 20 && recieverInput.length() <= 18) {
      recieverInput += key;
    }

    if (isRecieverFinished && k == BACKSPACE) {
      try {
        recieverInput = recieverInput.substring(0, recieverInput.length()-1);
      }
      catch(Exception e) {
      }
    }

    //Message
    if (isMessageFinished && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
      && k != 0 && k != UP && k != LEFT && k != DOWN && k != RIGHT && k != 157 && k != 20 && messageInput.length() <= 200) {
      messageInput += key;
    }
    if (isMessageFinished && k == ENTER) {
      messageInput += "\n";
    }
    if (isMessageFinished && k == BACKSPACE) {
      try {
        messageInput = messageInput.substring(0, messageInput.length()-1);
      }
      catch(Exception e) {
      }
    }
    if (k == ENTER && isMessageProceedButtonHighlighted) {
      if (db.connect()) {
        User recieveUser = new User(); 
        recieveUser.UserID = 2;
        SendMessageToDB(user, recieveUser, messageInput);
        screen = 3;
        
        println("Loading messages from database... \n");
        for (ReadMessage message : LoadMessagesFromDB()) {
          //println(message.SenderName);
          //println(message.RecieverName);
          println(message.SenderName + " -> " + message.RecieverName);
          println(message.Message);
          println("");
        }
      }
    }
  }

  if (screen == 3) {
  }
}

void keyReleased() {
  final int k = keyCode;
  if (screen == 1) {
    if (k == TAB && !isUsernameFinished) { 
      //Switch to Password 
      isUsernameFinished = true;
      isPasswordFinished = true;
    } else if (k == TAB && isPasswordFinished) {
      //Switch to Proceed Button 
      isProceedButtonHighlighted = true;
      isPasswordFinished = false;
    } else if (k == TAB && isProceedButtonHighlighted) {
      //Switch to Username 
      isProceedButtonHighlighted = false;
      isUsernameFinished = false;
    }
  }

  if (screen == 2) {
    if (k == TAB && isRecieverFinished) {
      isRecieverFinished = false;
      isMessageFinished = true;
    } else if (k == TAB && isMessageFinished) {
      isMessageFinished = false;
      isMessageProceedButtonHighlighted = true;
    } else if (k == TAB && isMessageProceedButtonHighlighted) {
      isMessageProceedButtonHighlighted = false;
      isRecieverFinished = true;
    }
  }
}
