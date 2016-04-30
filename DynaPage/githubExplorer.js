//



// init ui

var lblApp = Label.create({
                           rect: Rect.create({x: 25, y: 150, width:250, height:30}),
                           text: "please enter github username"
                           });

var txtUserName = TextBox.create({
  placeholder: "gitgub username",
  rect: Rect.create({x: 50, y: 200, width:200, height:30}),
  edited: function(value) {
     //
  }
});

var btnGetRepos = Button.create({
                                title: "Get Repos",
                                rect: Rect.create({x: 50, y: 240, width:200, height:50}),
                                
                                click: function() {
                                    log("getting repos!");
                                    getReposForUser(txtUserName.text);
                                }
});


function getReposForUser(user) {
    var dataString = download("https://api.github.com/users/yortuc/repos");
    var arrRepos = JSON.parse(dataString);
    var reposDataSource = arrRepos.map(function(repo){
      return repo.name
    });

    listRepos(reposDataSource)
}

function listRepos(repos){
    
    var reposTableView = TableView.create({
       items: repos
    });
    
    present(reposTableView);
}


/*
var repoLabels = [];

function listRepos(repos) {
    repos.forEach(function(repo, index) {
        log(repo.name);
                    
                    var lblRepo = Label.create({
                     rect: Rect.create({x: 50, y: 160 + index*40, width:200, height:30}),
                     text: repo.name
                    });
                  
                  repoLabels.push(lblRepo);
    });
}*/