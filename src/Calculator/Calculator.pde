// Ivan Montano | Setempber 15, 2026 | Calculator
Button[] numButtons = new Button[10];
Button[] opButtons = new Button [13];
float l, r, result;
char op;
boolean left;
String displayVal;
boolean newEntry;

void setup() {
  size(320, 440);

  l = 0.0;
  r = 0.0;
  result = 0.0;
  op = ' ';
  left = true;
  displayVal="0.0";
  newEntry=true;

  numButtons[0] = new Button(60, 400, 60, 60, '0');
  numButtons[1] = new Button(60, 330, 60, 60, '1');
  numButtons[2] = new Button(130, 330, 60, 60, '2');
  numButtons[3] = new Button(200, 330, 60, 60, '3');
  numButtons[4] = new Button(60, 260, 60, 60, '4');
  numButtons[5] = new Button(130, 260, 60, 60, '5');
  numButtons[6] = new Button(200, 260, 60, 60, '6');
  numButtons[7] = new Button(60, 190, 60, 60, '7');
  numButtons[8] = new Button(130, 190, 60, 60, '8');
  numButtons[9] = new Button(200, 190, 60, 60, '9');
  opButtons[0] = new Button(260, 330, 40, 40, '+');
  opButtons[1] = new Button(260, 380, 40, 40, '±');
  opButtons[2] = new Button(260, 280, 40, 40, '-');
  opButtons[3] = new Button(260, 230, 40, 40, 'x');
  opButtons[4] = new Button(260, 180, 40, 40, '÷');
  opButtons[5] = new Button(190, 400, 90, 60, '=');
  opButtons[6] = new Button(118, 400, 40, 60, '.');
  opButtons[7] = new Button(260, 135, 40, 40, 'C');
  opButtons[8] = new Button(215, 135, 40, 40, '%');
  opButtons[9] = new Button(170, 135, 40, 40, '²');
  opButtons[10] = new Button(125, 135, 40, 40, 'π');
  opButtons[11] = new Button(80, 135, 40, 40, '√');
  opButtons[12] = new Button(35, 135, 40, 40, '^');
}

void draw () {
  background(33);
  drawDisplay();
  for (int i = 0; i<numButtons.length; i++) {
    textSize(22);
    numButtons[i].display();
    numButtons[i].mouseOver(mouseX, mouseY);
  }
  for (int i = 0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].mouseOver(mouseX, mouseY);
  }
}

void drawDisplay() {
  rectMode(CENTER);
  rect(width/2, 50, 290, 80);
  fill(0);
  textAlign(RIGHT);
  textSize(45);
  text(displayVal, width-45, 80);
}

void mouseReleased() {
  // Update display with button clicked by user
  for (int i = 0; i < numButtons.length; i++ ) {
    if (numButtons[i].hover) {
      handleEvent(numButtons[i].val, true);
    }
  }
  // Loop through opButtons
  for (int i = 0; i < opButtons.length; i++) {
    if (opButtons[i].hover) {
      handleEvent(opButtons[i].val, false);
    }
  }
  // Display Variables
  println("L:" + l);
  println("R:" + r);
  println("Result:" + result);
  println("Left:" + left);
  println("Op:" + op);
}

void performCalc() {
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '÷') {
    result = l / r;
  } else if (op == 'x') {
    result = l * r;
  } else if (op == '^') {
    result = pow(l, r);
  } else if (op == '²') {
    result = sq(l);
  }
  displayVal= str(result);
  left = !left;
}

void keyPressed() {
  println("keyCode: " + keyCode);
  if ( key == '%') {
    handleEvent( '%', false);
  } else if (keyCode == 49 || keyCode == 97) {
    handleEvent('1', true);
  } else if (keyCode == 50 || keyCode == 98) {
    handleEvent('2', true);
  } else if (keyCode == 51 || keyCode == 99) {
    handleEvent('3', true);
  } else if (keyCode == 52 || keyCode == 100) {
    handleEvent('4', true);
  } else if (keyCode == 53 || keyCode == 101) {
    handleEvent('5', true);
  } else if (keyCode == 54 || keyCode == 102) {
    handleEvent('6', true);
  } else if (keyCode == 55 || keyCode == 103) {
    handleEvent('7', true);
  } else if (keyCode == 56 || keyCode == 104) {
    handleEvent('8', true);
  } else if (keyCode == 57 || keyCode == 105) {
    handleEvent('9', true);
  } else if (keyCode == 48 || keyCode == 96) {
    handleEvent('0', true);
  } else if (keyCode == 45 || keyCode == 109) {
    handleEvent('-', false);
  } else if (keyCode == 107) {
    handleEvent('+', false);
  } else if (keyCode == 47 || keyCode == 111) {
    handleEvent('÷', false);
  } else if (keyCode == 10) {
    handleEvent('=', false);
  } else if ( keyCode == 106) {
    handleEvent('x', false);
  }
}


void handleEvent(char val, boolean isNum) {
  if (isNum == true) {
    // Do number Stuff
    String digit = str(val);

    if (newEntry || displayVal.equals("0.0")) {
      displayVal = digit;
      newEntry= false;
    } else {
      displayVal += digit;
    }

    if (left) {
      l = float(displayVal);
    } else {
      r = float(displayVal);
    }
  } else {
    // Operarator Stuff
    char clicked = val;

    // Perform a caculation
    if (clicked == '=') {
      performCalc();
    } else if (clicked == '+' || clicked == '-' ||
      clicked == 'x' || clicked == '÷' || clicked == '^') {
      op = clicked;
      left = false;
      newEntry = true;
      displayVal = str(op);
    } else if (clicked == '±') {
      if (left == true) {
        l *= -1;
        displayVal = str(l);
      } else {
        r *= -1;
        displayVal = str(r);
      }
    } else if (clicked == 'C') {
      // reset all variables
      l = 0.0;
      r = 0.0;
      result = 0.0;
      op = ' ';
      left = true;
      displayVal="0.0";
      newEntry=true;
    } else if (clicked == '√') {
      // square root
      if (left == true) {
        l = sqrt(l);
        displayVal = str(l);
      } else {
        r = sqrt(r);
        displayVal = str(r);
      }
    } else if (clicked == '^') {
      // exponent
      if (left == true) {
        l =  pow(l, r);
        displayVal = str(l);
      } else {
        r = pow(l, r);
        displayVal = str(r);
      }
    } else if (clicked == '²') {
      // squared
      if (left == true) {
        l = sq(l);
        displayVal = str(l);
      }
    } else if (clicked == 'π') {
      // pi
      if (left == true) {
        l = 3.14159;
        displayVal = str(l);
      } else {
        r = 3.14159;
        displayVal = str(l);
      }
    } else if (clicked == '.') {
      if (!displayVal.contains(".")) {
        displayVal += ".";
      }
    } else if ( clicked == '%') {
      if (left == true) {
        l= l / 100.0;
        displayVal = str(l);
      } else {
        r= r / 100.0;
        displayVal = str(r);
      }
    }
  }
}
