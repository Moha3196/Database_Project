public ArrayList<User> LoadContactListFromDB() {
  
  ArrayList<User> contactListArray = new ArrayList<User>();
  db.query("SELECT * FROM Users WHERE UserID != %s;", user.UserID);

  while (db.next()) {
    User contactUser = new User();
    db.setFromRow(contactUser);    
    contactListArray.add(contactUser);
  }

  return contactListArray;
}

//Create User
void CreateUser(String userToBeCreated, String passwordToBeCreated) {
  db.query("INSERT INTO Users (Username, Password) VALUES ('%s', '%s')", userToBeCreated, passwordToBeCreated); 
}
