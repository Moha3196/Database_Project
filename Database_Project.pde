
/*keyCode = 157 For Mac CMD/Command*/
/*keyCode = 20 For Capslock*/
import static javax.swing.JOptionPane.*;
import de.bezier.data.sql.*;
SQLite db;
int screen = 1;
String username = "";
String password = "";
boolean isUsernameFinished, isPasswordFinished = false;
PFont font;
String test;



void setup() {
  size(1000, 600);
  
  db = new SQLite( this, "SQLite Database-projekt.db" );  // open database file
}



void draw() {
  //Changes the screens
  if (screen == 1) {
    LogIn();
  }
}



void keyPressed() {
  final int k = keyCode;
  if (screen == 1) {
    //Username
    if (!isUsernameFinished && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
      && k != UP && k != LEFT && k != DOWN && k != RIGHT && keyCode != 157 && keyCode != 20 && username.length() <= 18) {
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
      && k != UP && k != LEFT && k != DOWN && k != RIGHT && keyCode != 157 && keyCode != 20 && password.length() <= 18) {
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

    if (k == ENTER) {
      // If thre is connection to database, proceed with checking user input.
      if (db.connect()) {
        if (CheckLogIn(username, password)) {
          // If CheckLogIn returns true in case of correct user input, the program navigates to next screen.
          println("You have successfully logged in!");
          //screen = 2;
        } else {
          println("FAILED LOG-IN");
          // Shows a message dialog for when user input is incorrect.
          showMessageDialog(null, "The provided login credentials are not correct!", "Login error", ERROR_MESSAGE);
        }
      }
    }
  }
}

void keyReleased() {
  final int k = keyCode;
  if (screen == 1) {
    //Switch to Password 
    if (k == TAB && !isUsernameFinished) { 
      isUsernameFinished = true;
      isPasswordFinished = true;
    } else if (k == TAB && isUsernameFinished == true) { 
      isUsernameFinished = false;
      isPasswordFinished = false;
    }
  }
}
