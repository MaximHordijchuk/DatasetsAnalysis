app.service('Page', ['$rootScope', function ($rootScope) {
    this.goto = function (newPage) {
        $rootScope.page = newPage;
    };
}]);