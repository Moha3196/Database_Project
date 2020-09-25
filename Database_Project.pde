import de.bezier.data.sql.*;
SQLite db;
int screen = 1;
String username = "";
String password = "";
boolean isUsernameFinished = false;
boolean isPasswordFinished = false;
PFont font;



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
    }
  }
}



void draw() {
  background(255);
  textAlign(LEFT);
  font = createFont("Verdana", 20);
  textFont(font);
  stroke(0);
  strokeWeight(2);
  fill(0);
  text("Username", width/6-70, height/3-27.5);
  fill(255);
  rect(width/4, height/3-50, width/2, 30);
  fill(0);
  text("Password", width/6-70, height/3+10);
  fill(255);
  rect(width/4, height/3-12.5, width/2, 30);
  fill(0);
  text(username, width/4+5, height/3-48.5, width/2-10, 30);
  fill(0);
  text(password, width/4+5, height/3-12.5, width/2-10, 30);
}

void keyPressed() {
  final int k = keyCode;
  if (screen == 1) {
    //Username
    if (!isUsernameFinished && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB) {
      username += key;
    }
    
    if (k == BACKSPACE && !isUsernameFinished) {
      try {
        username = username.substring(0, username.length()-1);
      }
      catch(Exception e) {
      }
    }


    //Password
    if (isPasswordFinished && k != BACKSPACE && k != CONTROL && k != SHIFT && k != ALT && k != ENTER && k != TAB) {
      password += key;
      println(password);
    }
    
    if (k == BACKSPACE && isPasswordFinished == true) {
      try {
        password = password.substring(0, password.length()-1);
      }
      catch(Exception e) {
      }
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
