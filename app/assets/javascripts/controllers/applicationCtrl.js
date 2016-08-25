app.controller('ApplicationCtrl', ['$scope', '$rootScope', 'Page', 'Auth', function ($scope, $rootScope, Page, Auth) {
    $rootScope.datasets = { dataset: '', second_dataset: '' };

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
}]);