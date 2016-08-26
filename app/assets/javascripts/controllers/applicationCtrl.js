app.controller('ApplicationCtrl', ['$scope', '$rootScope', 'Page', 'Auth', function ($scope, $rootScope, Page, Auth) {
    // Share datasets between analyze and correlation controllers
    $rootScope.datasets = { dataset: '', second_dataset: '' };

    // Global function for switching the pages
    $scope.goto = function (page) {
        Page.goto(page);
        console.log("Goto " + page);
    };

    // Global function for check if user is authenticated
    $scope.isAuthenticated = function () {
        return Auth.isAuthenticated();
    };

    // Initialize main page
    Auth.currentUser().then(function (user) {
        console.log("Logged in as " + user.username);
        Page.goto('index');
        console.log("Goto index");
    }, function () {
        Page.goto('signin');
        console.log("Goto signin");
    });
}]);