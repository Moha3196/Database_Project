class TableOne {
  public int CustomerID;
  public String Name;
  public String Address;
  
  public String toString () {
    return String.format("CustomerID: %s   Name: %s   Address: %s", CustomerID, Name, Address);
  }
}
