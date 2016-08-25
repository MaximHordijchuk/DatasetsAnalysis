app.controller('CorrelationCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.calculate = function () {
        console.log("Sending datasets to the server");
        $http({
            method: 'POST',
            url: '/correlation',
            data: {
                dataset1: $scope.datasets.dataset,
                dataset2: $scope.datasets.second_dataset
            }
        }).then(function successCallback(response) {
            console.log("Response received");
            console.log(response);
            $scope.result = response.data.result;
        }, function errorCallback(response) {
            // called asynchronously if an error occurs
            // or server returns response with an error status.
        });
    }
}]);