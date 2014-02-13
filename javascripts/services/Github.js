/*
# Github Service
#
# This service is use for get staff's profile from github repo
*/


(function() {
  var App;

  App = angular.module("Service.Github", ["ngResource"]);

  App.factory("Github", [
    "$resource", function($resource) {
      var url;

      url = "https://api.github.com/repos/sitcon-tw/staff-card/contents/:username/:file";
      return $resource(url, {}, {
        info: {
          method: "GET",
          headers: {
            "Accept": "application/vnd.github.raw"
          },
          params: {
            file: "info.json"
          }
        },
        biography: {
          method: "GET",
          headers: {
            "Accept": "application/vnd.github.raw"
          },
          params: {
            file: "biography.md"
          },
          transformResponse: function(data, headers) {
            return {
              markdown: data
            };
          }
        }
      });
    }
  ]);

}).call(this);
