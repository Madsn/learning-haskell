'use strict';

angular.module('ranklists')
  .config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/scoreboard', {
        templateUrl: 'views/scoreboard/scoreboard.html',
        controller: 'ScoreboardController'
      })
    }]);
