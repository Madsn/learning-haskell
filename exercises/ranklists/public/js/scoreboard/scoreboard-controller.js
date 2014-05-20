'use strict';

angular.module('ranklists')
  .controller('ScoreboardController', ['$scope', 'resolvedTeam',
    function ($scope, resolvedTeam) {

      $scope.teams = resolvedTeam;

    }]);
