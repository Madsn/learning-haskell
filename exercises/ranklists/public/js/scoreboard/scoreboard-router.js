'use strict';

angular.module('ranklists')
  .config(['$routeProvider', function ($routeProvider) {
    $routeProvider
      .when('/scoreboard', {
        templateUrl: 'views/scoreboard/scoreboard.html',
        controller: 'ScoreboardController',
        resolve:{
          resolvedTeam: ['Team', function (Team) {
            return Team.query(function (objs) {
              // deal with Haskell Persistent json format
              for (var i = 0; i < objs.length; i++) {
                var obj = objs[i];
                obj.id = obj.key;
                delete obj.key;
                for (var prop in obj.value) {
                  obj[prop] = obj.value[prop];
                }
                delete obj.value;
              }
            });
          }]
        }
      })
    }]);
