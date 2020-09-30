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
