log("hello there!")


var firstButton = Button.create({
  title: "Example button",
  x: 50,
  y: 200,
  width: 200,
  height: 50,

  click: function() {
    log("Button clicked!");
    myLabel.text = "Logging in...";
  }
});

firstButton.title = "I changed button title";

log(firstButton.title);

var myLabel = Label.create({
  x: 50,
  y: 100,
  width: 200,
  height: 30,
  text: "Welcome, please enter your username"
});

var txtUserName = TextBox.create({
  placeholder: "my textbox",
  x: 50,
  y: 150,
  width: 200,
  height: 30,

  edited: function(value) {
    log("txtUserName edited. value: " + value);
    myLabel.text = "Hello " + txtUserName.text;
  }
});

