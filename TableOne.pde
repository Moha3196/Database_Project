class TableOne {
  public int UserID;
  public String Username;
  public String Password;
  
  public String toString () {
    return String.format("UserID: %s   Username: %s   Password: %s", UserID, Username, Password);
  }
}
