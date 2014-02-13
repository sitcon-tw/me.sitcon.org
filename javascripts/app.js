/*
# SITCON Staff Business Card
*/


(function() {
  var App, generateLinkObject;

  App = angular.module("SITCON", ["ngRoute", "ngSanitize", "ngAnimate", "Service.Staff", "Service.Github"]);

  /*
  # Config
  */


  App.config([
    "$routeProvider", "$locationProvider", function($routeProvider, $locationProvider) {
      $routeProvider.when("/", {
        templateUrl: "templates/list.html",
        controller: "ListCtrl"
      }).when("/:username", {
        templateUrl: "templates/profile.html",
        controller: "ProfileCtrl"
      }).otherwise({
        redirectTo: "/"
      });
      return $locationProvider.html5Mode(true);
    }
  ]);

  /*
  # Filter
  */


  App.filter("markdown", function() {
    return function(input) {
      if (input) {
        return markdown.toHTML(input.toString());
      }
    };
  });

  /*
  # Controllers
  */


  App.controller("ListCtrl", [
    "$scope", "Staff", function($scope, Staff) {
      $scope.loading = true;
      $scope.staffList = {};
      return Staff.get(function(result) {
        $scope.loading = false;
        return $scope.staffList = result.users;
      });
    }
  ]);

  generateLinkObject = function(type, data) {
    switch (type) {
      case "website":
        return {
          name: "Website",
          href: data
        };
      case "facebook":
        return {
          name: "Facebook",
          href: "https://fb.me/" + data
        };
      case "plurk":
        return {
          name: "Plurk",
          href: "https://plurk.com/" + data
        };
      case "twitter":
        return {
          name: "Twitter",
          href: "https://twitter.com/" + data
        };
    }
  };

  App.controller("ProfileCtrl", [
    "$scope", "$routeParams", "$q", "$location", "Staff", "Github", function($scope, $params, $q, $location, Staff, Github) {
      var linkTypes, params;

      linkTypes = ["website", "facebook", "plurk", "twitter"];
      $scope.loading = true;
      $scope.profile = {};
      $scope.information = {};
      $scope.biography = {};
      $scope.links = [];
      $scope.hasError = false;
      params = {
        username: $params.username
      };
      return $q.all({
        profile: (Staff.get(params)).$promise,
        information: (Github.info(params)).$promise,
        biography: (Github.biography(params)).$promise
      }).then(function(results) {
        var linkType, _i, _len, _results;

        $scope.loading = false;
        $scope.profile = results.profile.user;
        $scope.information = results.information;
        $scope.biography = results.biography.markdown;
        _results = [];
        for (_i = 0, _len = linkTypes.length; _i < _len; _i++) {
          linkType = linkTypes[_i];
          if ($scope.information[linkType]) {
            _results.push($scope.links.push(generateLinkObject(linkType, $scope.information[linkType])));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      }, function(error) {
        $scope.hasError = true;
        return $scope.error = "喔喔，好像找不到這個人的自我介紹。";
      });
    }
  ]);

}).call(this);
