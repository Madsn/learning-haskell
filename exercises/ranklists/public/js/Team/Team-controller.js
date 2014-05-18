'use strict';

angular.module('ranklists')
  .controller('TeamController', ['$scope', '$modal', 'resolvedTeam', 'Team',
    function ($scope, $modal, resolvedTeam, Team) {

      $scope.teams = resolvedTeam;

      $scope.create = function () {
        $scope.clear();
        $scope.open();
      };

      $scope.update = function (id) {
        $scope.team = Team.get({id: id}, function (obj) {
          // deal with Haskell Persistent json format
          obj.id = obj.key;
          delete obj.key;
          for (var prop in obj.value) {
            obj[prop] = obj.value[prop];
          }
          delete obj.value;
        });
        $scope.open(id);
      };

      $scope.delete = function (id) {
        Team.delete({id: id},
          function () {
            $scope.teams = Team.query(transformObjs);
          });
      };

      $scope.save = function (id) {
        if (id) {
          var obj = {};
          for (var prop in $scope.team) {
            // remove id for Haskell Persistent json format
            if (prop !== "id") obj[prop] = $scope.team[prop];
          }
          //Team.update({id: id}, $scope.team,
          Team.update({id: id}, obj,
            function () {
              $scope.teams = Team.query(transformObjs);
              $scope.clear();
            });
        } else {
          Team.save($scope.team,
            function () {
              $scope.teams = Team.query(transformObjs);
              $scope.clear();
            });
        }
      };

      $scope.clear = function () {
        $scope.team = {
          
          "name": "",
          
          "id": ""
        };
      };

      $scope.open = function (id) {
        var teamSave = $modal.open({
          templateUrl: 'team-save.html',
          controller: TeamSaveController,
          resolve: {
            team: function () {
              return $scope.team;
            }
          }
        });

        teamSave.result.then(function (entity) {
          $scope.team = entity;
          $scope.save(id);
        });
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

    }]);

var TeamSaveController =
  function ($scope, $modalInstance, team) {
    $scope.team = team;

    

    $scope.ok = function () {
      $modalInstance.close($scope.team);
    };

    $scope.cancel = function () {
      $modalInstance.dismiss('cancel');
    };
  };
