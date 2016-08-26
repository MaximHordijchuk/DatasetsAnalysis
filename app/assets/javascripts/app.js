var app = angular.module("datasetsAnalysis", ["Devise", "ui-notification", 'angular-loading-bar']);

app.config(function(NotificationProvider) {
    NotificationProvider.setOptions({
        delay: 3000,
        startTop: 15,
        startRight: 10,
        verticalSpacing: 20,
        horizontalSpacing: 20,
        positionX: 'left',
        positionY: 'bottom'
    });
});

function capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}