
void LogIn() {
  background(255);
  
  textAlign(LEFT);
  font = createFont("Verdana", 20);
  textFont(font);
  stroke(0);
  strokeWeight(2);
  
  //Text box for Username
  fill(0);
  text("Username", width/6-70, height/3-27.5);
  //Higlight Username Box
  if (!isUsernameFinished) { fill(220); } else { fill(255); }
  rect(width/4, height/3-50, width/2, 30);
  
  //Text box for Password
  fill(0);
  text("Password", width/6-70, height/3+10);
  //Higlight Password Box
  if (isPasswordFinished == true){ fill(220); } else { fill(255); }
  rect(width/4, height/3-12.5, width/2, 30);
  
  //Text box for Proceed Button
  if (isProceedButtonHighlighted == true){ fill(220); } else { fill(255); }
  rect(width/4*3-70, height/3*2, 70, 30);
  fill(0);
  text("Log In", width/4*3-67.5, height/3*2, 120, 30);
  
  //The Text in Username
  fill(0);
  text(username, width/4+5, height/3-48.5, width/2-10, 30);

  //The Text in Password
  fill(0);
  text(password, width/4+5, height/3-12.5, width/2-10, 30);
}
