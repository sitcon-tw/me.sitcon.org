###
# SITCON Staff Service
#
# This service is use for get staff list
###

App = angular.module "Service.Staff", ["ngResource"]

App.factory "Staff", ["$resource", "$http", ($resource, $http) ->
  $http.defaults.useXDomain = true
  return $resource "http://staff.sitcon.org/users/:username/ /", { # This url have some black magic, don't touch it...
  }, {
    get: {
      method: "GET"
      headers: {
        "X-Requested-With": "XMLHttpRequest"
      }
    }
  }
]
