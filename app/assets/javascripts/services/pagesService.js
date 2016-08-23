app.service('Page', function ($rootScope) {
    this.goto = function (newPage) {
        $rootScope.page = newPage;
    };
});