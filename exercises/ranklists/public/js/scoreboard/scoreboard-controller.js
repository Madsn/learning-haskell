'use strict';

angular.module('ranklists')
  .controller('ScoreboardController', ['$scope', '$filter', 'resolvedTeam', 'Team',
    function ($scope, $filter, resolvedTeam, Team) {

      $scope.teams = resolvedTeam;

      $scope.incrementScore = function(id){
        var team = $filter('getById')($scope.teams, id)
        team.score = team.score+1;
      };

      $scope.decrementScore = function(id){
        var team = $filter('getById')($scope.teams, id)
        team.score = team.score-1;
      };

      $scope.resetScore = function(id){
        var team = $filter('getById')($scope.teams, id)
        team.score = 0;
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