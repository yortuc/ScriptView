var styles = {
	textBox: {
		left: 0
		right: 0
	}
};

//
// component structure
// var view = Rn.View(props, childs);
//

var UserForm = Rn.createClass({
	getInitialState: function(){
		return { userName: "yortuc" }
	},

	_userNameChanged: function(newValue){
		this.setState({ userName: newValue });
	},

	_buttonClicked: function(){
		this.props.onSubmit(this.state.userName);
	},

	render: function(){
		return Rn.View({ style: styles.view }, [
			Rn.Label({ text: this.props.formTitle, style: styles.label }),
			Rn.Textbox({ placeholder:"user name", onChange: this._userNameChanged, style: styles.textbox }),
			Rn.Button({ text: "Get Repos", onClick: this._buttonClicked, style: styles.button })
		]);
	}
});

var InitialPage = Rn.createClass({
	_getRepos: function(userName){
		var reposData = $.get("github.com/repos/"+userName);
		var reposArr = reposData.map(function(repo){return repo.name});
		this.setState({ 
			tableViewVisible: true,
			repos: reposArr
		});
	},

	render: function(){
		return Rn.View({style: styles.appView}, [
			UserForm({ formTitle: "Github Explorer", onSubmit: this._getRepos }),
			Rn.Tableview({ visible: this.state.tableViewVisible, items: this.state.repos })
		]);
	}
});

Rn.run(InitialPage);
