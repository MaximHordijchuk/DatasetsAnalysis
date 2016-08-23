app.controller('AnalyzeCtrl', function ($scope, $http) {
    $scope.analyze = function () {
        console.log('Analyze invoked!');
        $http({
            method: 'POST',
            url: '/analyze',
            data: { dataset: $scope.dataset }}
        ).then(function successCallback(response) {
            console.log(response);
            $scope.results = response.data;
            $scope.results.outliers = $scope.results.outliers.join(',')
        }, function errorCallback(response) {
            // called asynchronously if an error occurs
            // or server returns response with an error status.
        });
    }
});