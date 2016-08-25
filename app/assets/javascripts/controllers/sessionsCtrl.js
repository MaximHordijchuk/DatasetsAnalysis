app.controller('SessionsCtrl', ['$scope', 'Page', 'Auth', function($scope, Page, Auth) {
    var config = {
        headers: {
            'X-HTTP-Method-Override': 'POST'
        }
    };

    $scope.login = function () {
        var credentials = {
            username: $scope.username,
            password: $scope.password
        };
        console.log("Trying to log in as " + credentials.username);
        Auth.login(credentials, config).then(function (user) {
            Page.goto('index');
            console.log("Logged in as " + user.username);
        }, function (error) {
            console.log(error);
        });
    };

    $scope.register = function () {
        var credentials = {
            username: $scope.username,
            password: $scope.password
        };
        console.log("Trying to register user " + credentials.username);
        Auth.register(credentials, config).then(function (user) {
            Page.goto('index');
            console.log("Registered new user " + user.username);
        }, function (error) {
            console.log(error);
        });
    };

    $scope.logout = function () {
        Auth.logout().then(function (oldUser) {
            Page.goto('signin');
            console.log('Log out user ' + oldUser.username);
        }, function (error) {
            console.log(error);
        });
    };
}]);