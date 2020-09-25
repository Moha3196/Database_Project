import de.bezier.data.sql.*;
SQLite db;
int screen = 1;
String password = "awidawdidwn";
boolean isFinished = false;


void setup() {
  size(100, 100);

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
}

void keyPressed() {
  if (screen == 1) {
    if (!isFinished && key != BACKSPACE) {
      password += key;
    }

    if (key == BACKSPACE) {
      //password = password.substring(0,password.length()-1);
      
      try {
        password = password.substring(0, password.length()-1);
      }
      catch(Exception e) {
      }
      
    }

    if (key == ENTER) { 
      isFinished = true;
    }
    println(password);
  }
}
