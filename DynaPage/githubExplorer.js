// init ui
var lblApp = Label.create({
  rect: Rect.create({x: 25, y: 150, width:250, height:30}),
  text: "please enter github username"
});

var txtUserName = TextBox.create({
  placeholder: "gitgub username",
  rect: Rect.create({x: 50, y: 200, width:200, height:30}),
                                 text: "yortuc"
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
    var dataString = download("https://api.github.com/users/"+user+"/repos");
    var arrRepos = JSON.parse(dataString);

    listRepos(user, arrRepos);
}

function listRepos(userName, repos){
    
    var repoNames = repos.map(function(repo){
                              return repo.name;
                    });
    
    var reposTableView = TableView.create({
       title: userName + "'s Repos",
       items: repoNames,
       onItemSelected: function(itemIndex) {
          log(repos[itemIndex].name);
          showRepoDetails2(repos[itemIndex]);
        }
    });
    
    present(reposTableView);
}

function showRepoDetails(repo){
    // ui for repo details
    var pageRootView = View.create({
     rect: Rect.create({x: 0, y: 66, width:320, height:400 }),
     backgroundColor: "#ffa500"
    })
    
    var lblRepoName = Label.create({
      rect: Rect.create({x: 50, y: 100, width:200, height:30}),
      text: repo.name
    });
    
    pageRootView.addChild(lblRepoName);
    
    var pageRepoDetails = PageView.create({
        title: repo.name,
        rootView: pageRootView
    });
    
    present(pageRepoDetails);
}

function showRepoDetails2(repo){
    
    var items = [{ text: "Name", value: repo.name},
                 { text: "Description", value: repo.description},
                 { text: "Size", value: repo.size.toString() }];
   
    var pageRepoDetails = CustomTableView.create({
                                          title: repo.name + " Details",
                                          items: items,
                                                onRenderRow: function(itemIndex) {
                                                    var data = items[itemIndex];
                                                
                                                    var cellView = View.create({
                                                       rect: Rect.create({x: 0, y: 0, width:320, height:200 }),
                                                       backgroundColor: "#ffffff"
                                                    });
                                                
                                                    var lblText = Label.create({
                                                       rect: Rect.create({x: 0, y: 0, width:100, height:30}),
                                                       text: data.text
                                                    });
                                                
                                                    var lblValue = Label.create({
                                                       rect: Rect.create({x: 70, y: 0, width:200, height:30}),
                                                       text: data.value
                                                    });
                                                
                                                    cellView.addChild(lblText);
                                                    cellView.addChild(lblValue);
                                                
                                                    return cellView;
                                                }
                                          });
    
    present(pageRepoDetails);
}
