'use strict';

angular.module('ranklists')
  .controller('ScoreboardController', ['$scope', '$filter', 'Team',
    function ($scope, $filter, Team) {

      $scope.teams = Team.query(function (objs) {
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

      $scope.incrementScore = function(id){
        changeScore(id, +1);
      };

      $scope.decrementScore = function(id){
        changeScore(id, -1);
      };

      $scope.resetScore = function(id){
        var team = $filter('getById')($scope.teams, id)
        team.score = score;
        updateTeam(team);
      };

      var changeScore = function(id, val){
        var team = $filter('getById')($scope.teams, id)
        team.score = team.score + val;
        updateTeam(team);
      };

      var updateTeam = function(team){
        if (team.score < 0){
          team.score = 0;
        }
        Team.update({id: team.id}, team);
      };

      var transformObjs = function (objs) {
        // deal with Haskell Persistent json format
        for (var i = 0; i < objs.length; i++) {
          var obj = objs[i];
          obj.id = obj.key;
          delete obj.key;
          for (var prop in obj.value) {
            obj[prop] = obj.value[prop];
          }
          delete obj.value;
          console.log(obj);
        }
      };

    }]).filter('getById', function() {
      return function(input, id) {
        var i=0, len=input.length;
        for (; i<len; i++) {
          if (+input[i].id == +id) {
            return input[i];
          }
        }
        return null;
      }
});