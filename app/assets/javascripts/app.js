var app = angular.module("datasetsAnalysis", ["Devise", "ui-notification", 'angular-loading-bar']);

// Configuration for notifications
app.config(['NotificationProvider', function(NotificationProvider) {
    NotificationProvider.setOptions({
        delay: 3000,
        startTop: 15,
        startRight: 10,
        verticalSpacing: 20,
        horizontalSpacing: 20,
        positionX: 'left',
        positionY: 'bottom'
    });
}]);

// Capitalize first letter in the string
function capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}