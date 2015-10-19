'use strict';
var app = angular.module('Newsletter', ['ngResource', 'ngRoute']);
app.constant('Services', (function () {
    var api = 'http://localhost/newsletter/api/';
    return {
        users: api + 'users/:id'
        , newsletters: api + 'newsletters/:id'
    };
})());

app.config(['$routeProvider', function ($routeProvider) {
        $routeProvider.when('/n', {
            controller: 'mainController',
            templateUrl: 'tmpl/newsletters.html'
        });
//                .otherwise({redirectTo: '/'});
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
        };
    }
]);
app.controller('mainController', function ($scope) {
    $scope.message = 'Hello!';
});
app.controller('usersController', ['$scope', 'Factory', function ($scope, Factory) {
        $scope.users = Factory.Users.all();
        // Methods
        $scope.getUser = function (user_id) {
            alert(user_id);
        };
    }
]);
app.controller('newslettersController', ['$scope', 'Factory', function ($scope, Factory) {
        $scope.nresletters = Factory.Newsletters.all();
    }
]);