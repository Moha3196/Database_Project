
import de.bezier.data.sql.*;

SQLite db;

void setup() {
  size(100,100);
  
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
