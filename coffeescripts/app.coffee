###
# SITCON Staff Business Card
###

App = angular.module "SITCON", [
  # Angular Core
  "ngRoute"
  "ngSanitize"

  # Services
  "Service.Staff"
  "Service.Github"
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
# Filter
###

App.filter "markdown", ()->
  return (input) ->
    markdown.toHTML(input) if input

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

App.controller "ProfileCtrl", ["$scope", "$routeParams", "$q", "Staff", "Github", ($scope, $params, $q, Staff, Github) ->
  $scope.loading = true
  $scope.profile = {}
  $scope.infromation = {}
  $scope.biography = {markdown: ""}

  params = {username: $params.username}

  $q.all({
    profile: Staff.get(params)
    information: Github.info(params)
    biography: Github.biography(params)
  }).then (results) ->
    $scope.loading = false
    $scope.profile = results.profile
    $scope.infromation = results.information
    $scope.biography = results.biography

]

