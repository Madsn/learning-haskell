'use strict';

angular.module('ranklists')
  .controller('TeamController', ['$scope', '$modal', 'resolvedTeam', 'Team',
    function ($scope, $modal, resolvedTeam, Team) {

      $scope.Teams = resolvedTeam;

      $scope.create = function () {
        $scope.clear();
        $scope.open();
      };

      $scope.update = function (id) {
        $scope.Team = Team.get({id: id}, function (obj) {
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
            $scope.Teams = Team.query(transformObjs);
          });
      };

      $scope.save = function (id) {
        if (id) {
          var obj = {};
          for (var prop in $scope.Team) {
            // remove id for Haskell Persistent json format
            if (prop !== "id") obj[prop] = $scope.Team[prop];
          }
          //Team.update({id: id}, $scope.Team,
          Team.update({id: id}, obj,
            function () {
              $scope.Teams = Team.query(transformObjs);
              $scope.clear();
            });
        } else {
          Team.save($scope.Team,
            function () {
              $scope.Teams = Team.query(transformObjs);
              $scope.clear();
            });
        }
      };

      $scope.clear = function () {
        $scope.Team = {
          
          "name": "",
          
          "id": ""
        };
      };

      $scope.open = function (id) {
        var TeamSave = $modal.open({
          templateUrl: 'Team-save.html',
          controller: TeamSaveController,
          resolve: {
            Team: function () {
              return $scope.Team;
            }
          }
        });

        TeamSave.result.then(function (entity) {
          $scope.Team = entity;
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
  function ($scope, $modalInstance, Team) {
    $scope.Team = Team;

    

    $scope.ok = function () {
      $modalInstance.close($scope.Team);
    };

    $scope.cancel = function () {
      $modalInstance.dismiss('cancel');
    };
  };
