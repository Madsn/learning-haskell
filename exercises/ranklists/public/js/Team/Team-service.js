'use strict';

angular.module('ranklists')
  .factory('Team', ['$resource', function ($resource) {
    return $resource('ranklists/Teams/:id', {}, {
      'query': { method: 'GET', isArray: true},
      'get': { method: 'GET'},
      'update': { method: 'PUT'}
    });
  }]);
