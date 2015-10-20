'use strict';
var app = angular.module('Newsletter', ['ngResource', 'ngRoute', 'route-segment']);
app.constant('Services', (function () {
    var api = 'api/';
    return {
        users: api + 'users/:id'
        , newsletters: api + 'newsletters/:id'
        , types: api + 'types/:name'
    };
})());

app.config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
        $routeProvider
                .when('/', {controller: 'mainController', templateUrl: 'tmpl/newsletters.html'})
                .when('/newsletters/:page?', {controller: 'newslettersController', templateUrl: 'tmpl/newsletters.html'})
                .when('/users', {controller: 'usersController', templateUrl: 'tmpl/users.html'})
                .when('/logs', {controller: 'logsController', templateUrl: 'tmpl/logs.html'})
                .otherwise({redirectTo: '/'});
        if (window.history && window.history.pushState) {
            $locationProvider.html5Mode({
                enabled: true
                , requireBase: false
                , rewriteLinks: false
            });
        }
    }
]);

app.factory('Factory', ['$resource', 'Services', function ($resource, Services) {
        return {
            Users: $resource(Services.users, {}, {
                all: {method: 'GET', isArray: true}
                , get: {method: 'GET', params: {id: 0}, isArray: true}
            })
            , Newsletters: $resource(Services.newsletters, {}, {
                all: {method: 'GET', isArray: true}
                , get: {method: 'GET', params: {id: 0}, isArray: true}
            })
            , Types: $resource(Services.types, {}, {
                all: {method: 'GET', isArray: true}
                , get: {method: 'GET', params: {name: ''}, isArray: true}
            })
        };
    }
]);
app.controller('menuController', function ($scope, $location) {
    $scope.items = [
        {link: '/newsletters/add', icon: 'email', text: 'Newsletters'}
        , {link: '/', icon: 'email', text: 'Newsletters'}
        , {link: '/users', icon: 'face', text: 'Users'}
        , {link: '/logs', icon: 'list', text: 'Logs'}
    ];
    $scope.go = function ($path) {
        $location.path($path);
    };
});
app.controller('mainController', function ($scope) {
    $scope.message = 'Hello!';
});
app.controller('usersController', ['$scope', 'Factory', function ($scope, Factory) {
        $scope.users = Factory.Users.all();
        // Methods
        $scope.getUser = function (user_id) {
            $scope.user = Factory.Users.get({id: user_id});
            console.log($scope.user);
        };
    }
]);
app.controller('newslettersController', ['$scope', 'Factory', function ($scope, Factory) {
        $scope.newsletters = Factory.Newsletters.all();
        // Methods
        $scope.getNewsletter = function (newsletter_id) {
            $scope.newsletter = Factory.Newsletters.get({id: newsletter_id});
            console.log($scope.newsletter);
        };
    }
]);
app.controller('typesController', ['$scope', 'Factory', function ($scope, Factory) {
        $scope.types = Factory.Types.all();
        // Methods
        $scope.getType = function (type_name) {
            $scope.type = Factory.Types.get({name: type_name});
            console.log($scope.type);
        };
    }
]);
app.controller('logsController', function ($scope) {
    $scope.message = 'Hello!';
});