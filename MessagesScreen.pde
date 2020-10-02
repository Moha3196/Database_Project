

void ViewMessagesScreen() {
  background(255);

  textAlign(LEFT);
  font = createFont("Verdana", 20);
  textFont(font);
  stroke(0);
  strokeWeight(2);

  //Text box for Messages
  fill(0);
  text("Messages:", width/4, height/8-40);
  fill(255);
  rect(width/4, height/8+17.5-40, width/2, height/7*6-50);

  //Text box for Proceed Button
  if (isViewMessageProceedButtonHighlighted) { 
    fill(220);
  } else { 
    fill(255);
  }
  rect(width/4*3-150, height-50, 150, 30);
  fill(0);
  text("New Message", width/4*3-143.5, height-50, 200, 30);

  font = createFont("Verdana", 18);
  textFont(font);

  //The Text in Message
  int i = LoadMessagesFromDB().size()-4;
  if (amountMessagesShown < 4) {
    if (db.connect()) { 
      while (amountMessagesShown < 4) {
        //for (int i = LoadMessagesFromDB().size()-1; i < LoadMessagesFromDB().size(); i++) {
        //ReadMessage message = LoadMessagesFromDB().get(i);
        try {         
          viewMessage += LoadMessagesFromDB().get(i).SenderName + " -> " + LoadMessagesFromDB().get(i).RecieverName + "\n" + LoadMessagesFromDB().get(i).Message + "\n" + "\n";
        } 
        catch (Exception e) {}
        i++;
        amountMessagesShown += 1;
      }
    }
  }
     
  fill(0);
  text(viewMessage, width/4+5, height/8+22.5-40, width/2-10, height/7*6-60);
}
