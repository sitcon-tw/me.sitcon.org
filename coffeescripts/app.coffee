###
# SITCON Staff Business Card
###

App = angular.module "SITCON", [
  # Angular Core
  "ngRoute"

  # Services
  "Service.Staff"
]

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

App.controller "ListCtrl", ["$scope", "Staff", ($scope, Staff) ->
  $scope.loading = true
  $scope.staffList = {}
  Staff.get (result) ->
    $scope.loading = false
    $scope.staffList = result
]

App.controller "ProfileCtrl", ["$scope", "$routeParams", "Staff", ($scope, $params, Staff) ->
  $scope.loading = true
  $scope.profile = {}
  Staff.get {username: $params.username}, (result)->
    $scope.loading = false
    $scope.profile = result
]

