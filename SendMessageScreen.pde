
void SendMessageScreen() {
  background(255);

  textAlign(LEFT);
  font = createFont("Verdana", 20);
  textFont(font);
  stroke(0);
  strokeWeight(2);

  
  
  textAlign(LEFT);

  //Text box for Message
  fill(0);
  text("Message:", width/4, height/4+7.5);
  //Higlight Message Box
  if (isMessageHighlighted) { 
    fill(220);
  } else { 
    fill(255);
  }
  rect(width/4, height/4+17.5, width/2, height/3*2-50);

  //Text box for Proceed Button
  if (isMessageProceedButtonHighlighted == true) { 
    fill(220);
  } else { 
    fill(255);
  }
  rect(width/4*3-70, height-50, 70, 30);
  fill(0);
  text("Send", width/4*3-60, height-50, 120, 30);

  //The Text in Message
  fill(0);
  text(messageInput, width/4+5, height/4+19, width/2-10, height/3*2-60);
  
  //Text box for Reciever
  fill(0);
  text("To:", width/4, height/4-57.5);
  //Higlight Reciever Box
  if (isDropdownListPressed) {
    int y = height/4-50;
    for (int i = 0; i < contactListArray.size(); i++) {
      User users = contactListArray.get(i);
      textAlign(RIGHT);
      fill(255);
      stroke(255, 0, 0);
      if (mouseX <= width/4*3-10 && mouseX >= width/4 && mouseY <= y+30 && mouseY >= y) { fill(220);} else { fill(255);}
      rect(width/4, y, width/2, 30);
      stroke(0);
      fill(0);
      text(users.Username, width/4+5, y+1.5, width/2-10, 30);
      y += 37.5;
      if(mousePressed && mouseX <= width/4*3-10 && mouseX >= width/4 && mouseY <= y-3.5 && mouseY >= y-33.5){
        recieverInput = users.Username;
        isDropdownListPressed = false;
        isRecieverHighlighted = true;
      }
    }
  } else {
    if (isRecieverHighlighted) { fill(220);} else { fill(255);}
    stroke(0);
    strokeWeight(2);
    rect(width/4, height/4-50, width/2, 30);
    //The Text in Reciever
    fill(0);
    text(recieverInput, width/4+5, height/4-48.5, width/2-10, 30);
  }
}
