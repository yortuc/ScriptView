// ScriptView standart library

// Auto layout

var Layout = function(param){
	this.width = param.width;
	this.height = param.height;
	this.y = param.y;
}

Layout.prototype.centerHorizontal = function(){

	var rootRect = RootView.getRect();

	var x = (rootRect.width - this.width)/2;


}

/*

	// init layout with constraints
	var labelLayout = new Layout({y: 50, width: 100, height: 30});

	// apply autolayout
	labelLayout.centerHorizontal();

	var myLabel = Label.create({
	  rect: labelLayout.getRect(),
	  text: "Welcome, please enter your username"
	});
*/

module.exports = Layout;