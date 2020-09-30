
void SendMessageScreen(){
  background(255);
  
  textAlign(LEFT);
  font = createFont("Verdana", 20);
  textFont(font);
  stroke(0);
  strokeWeight(2);
  
  //Text box for Username
  fill(0);
  text("To:", width/4, height/4-57.5);
  //Higlight Reciever Box
  if (isRecieverHighlighted) { fill(220); } else { fill(255); }
  rect(width/4, height/4-50, width/2, 30);
  
  //Text box for Message
  fill(0);
  text("Message:", width/4, height/4+7.5);
  //Higlight Message Box
  if (isMessageHighlighted){ fill(220); } else { fill(255); }
  rect(width/4, height/4+17.5, width/2, height/3*2-50);
  
  //Text box for Proceed Button
  if (isMessageProceedButtonHighlighted == true){ fill(220); } else { fill(255); }
  rect(width/4*3-70, height-50, 70, 30);
  fill(0);
  text("Send", width/4*3-60, height-50, 120, 30);
  
  //The Text in Reciever
  fill(0);
  text(recieverInput, width/4+5, height/4-48.5, width/2-10, 30);

  //The Text in Message
  fill(0);
  text(messageInput, width/4+5, height/4+19, width/2-10, height/3*2-60);  
}
