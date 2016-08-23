app.controller('ApplicationCtrl', function ($scope, Page, Auth) {
    $scope.goto = function (page) {
        Page.goto(page);
        console.log("Goto " + page);
    };

    $scope.isAuthenticated = function () {
        return Auth.isAuthenticated();
    };

    Auth.currentUser().then(function (user) {
        console.log("Logged in as " + user.username);
        Page.goto('index');
        console.log("Goto index");
    }, function () {
        Page.goto('signin');
        console.log("Goto signin");
    });
});