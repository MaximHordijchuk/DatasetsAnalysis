// Service for switching the view blocks on the page
app.service('Page', ['$rootScope', function ($rootScope) {
    this.goto = function (newPage) {
        $rootScope.page = newPage;
    };
}]);