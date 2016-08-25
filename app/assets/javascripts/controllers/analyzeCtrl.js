app.controller('AnalyzeCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.analyze = function () {
        console.log("Sending dataset to the server");
        $http({
            method: 'POST',
            url: '/analyze',
            data: { dataset: $scope.datasets.dataset }
        }).then(function successCallback(response) {
            console.log("Response received");
            console.log(response);
            $scope.results = response.data;
            $scope.results.outliers = $scope.results.outliers.join(',')
        }, function errorCallback(response) {
            // called asynchronously if an error occurs
            // or server returns response with an error status.
        });
    }
}]);