class TableOne {
  public int CustomerID;
  public String Name;
  public String Adress;
  
  public String toString () {
    return String.format("CustomerID: %d Name: %s Adress: %s", CustomerID, Name, Adress);
  }
}
