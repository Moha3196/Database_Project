
/*keyCode = 157 For Mac CMD/Command*/
/*keyCode = 20 For Capslock*/

import de.bezier.data.sql.*;
SQLite db;
int screen = 1;
String username = "";
String password = "";
boolean isUsernameFinished = false;
boolean isPasswordFinished = false;
PFont font;
String test;



void setup() {
  size(500, 300);

  db = new SQLite( this, "SQLite Database-projekt.db" );  // open database file

  if ( db.connect() ) {
    String[] tableNames = db.getTableNames();

    db.query( "SELECT * FROM %s", tableNames[0] );

    while (db.next()) {
      TableOne t = new TableOne();
      db.setFromRow( t );
      println( t );
      test = t.Username;
    }
  }
}



void draw() {
  //Changes the screens
  if (screen == 1) {
    LogIn();
    if (keyPressed && keyCode == ENTER) {
      screen = 2;
    }
  }
}

void keyPressed() {
  final int k = keyCode;
  if (screen == 1) {
    //Username
    if (!isUsernameFinished && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
                            && keyCode != 157 && keyCode != 20 && username.length() <= 12) {
      username += key;
    }
    
    if (!isUsernameFinished && k == BACKSPACE) {
      try {username = username.substring(0, username.length()-1);}
      catch(Exception e) {}
     }
    
    //Password
    if (isPasswordFinished && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB 
                           && keyCode != 157 && keyCode != 20 && password.length() <= 12) {
      password += key;
      println(password);
    }

    if (isPasswordFinished && k == BACKSPACE) {
      try {password = password.substring(0, password.length()-1);}
      catch(Exception e) {}
    }
  }
}

void keyReleased() {
  final int k = keyCode;
  //Switch to Password 
  if (k == TAB && !isUsernameFinished) { 
    isUsernameFinished = true;
    isPasswordFinished = true;
  } else if (k == TAB && isUsernameFinished == true) { 
    isUsernameFinished = false;
    isPasswordFinished = false;
  }
}
