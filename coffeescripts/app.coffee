###
# SITCON Staff Business Card
###

App = angular.module "SITCON", ["ngRoute"]

###
# Config
###

App.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
  $routeProvider.when("/", {
    templateUrl: "templates/list.html"
    controller: "ListCtrl"
  })
  .when("/:username", {
    templateUrl: "templates/profile.html"
    controller: "ProfileCtrl"
  }).otherwise({
    redirectTo: "/"
  })

  $locationProvider.html5Mode(true)
]

###
# Controllers
###

App.controller "ListCtrl", ["$scope", ($scope) ->
  $scope.message = "Hello, List"
]

App.controller "ProfileCtrl", ["$scope", ($scope) ->
  $scope.message = "Hello, Profile"
]

