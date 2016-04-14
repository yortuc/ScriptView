// ScriptView standart library

function Sw() {
}

//********** actory methods for primitive components **********

sw.prototype.View = function(param) {
	return {
		type: "view",
		style: param.style,
		children: param.children
	}
}

Sw.prototype.Button = function(param) {

}