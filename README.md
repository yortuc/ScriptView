ScriptView
=====================

![ScriptView](screen.png)

A tiny view control that lets you create sub contols and event handlers dynamically with javascript.

##Sample Script
**main.js**

```js

var myStyles = require('myStyles');

// this is the final data structure to be rendered by native func Sw.render

var myLoginView = { 
  type: "view", 
  rect: Rect.create(0,0,500,500), 
  style: { backgroundColor: "#efefef" },
  props: { initialCount : 5 },            // will be passed to control.props
  children: [
  
      {type: "label",    rect: Rect.create(0,0,500,40),  props: {text: "Login"} },
      {type: "textbox",  rect: Rect.create(0,60,300,30), props: {placeholder: "Username"} },
      {type: "button",   rect: Rect.create(0,80,200,30), props: {text: "Log me in", onClick: function(){} } },

  ]}

Sw.render(myLoginView);

```