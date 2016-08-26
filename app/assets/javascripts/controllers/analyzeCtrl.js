app.controller('AnalyzeCtrl', ['$scope', '$http', 'Notification', function ($scope, $http, Notification) {
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
            Notification.error(capitalize(response.data.error));
        });
    }
}]);