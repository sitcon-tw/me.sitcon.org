###
# SITCON Staff Business Card
###

App = angular.module "SITCON", [
  # Angular Core
  "ngRoute"
  "ngSanitize"
  "ngAnimate"

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
    markdown.toHTML(input.toString()) if input

###
# Controllers
###

App.controller "ListCtrl", ["$scope", "Staff", ($scope, Staff) ->
  $scope.loading = true
  $scope.staffList = {}
  Staff.get (result) ->
    $scope.loading = false
    $scope.staffList = result.users
]

generateLinkObject = (type, data) ->
  switch type
    when "website" then return {name: "Website", href: data}
    when "facebook" then return {name: "Facebook", href: "https://fb.me/#{data}"}
    when "plurk" then return {name: "Plurk", href: "https://plurk.com/#{data}"}
    when "twitter" then return {name: "Twitter", href: "https://twitter.com/#{data}"}

App.controller "ProfileCtrl", ["$scope", "$routeParams", "$q", "$location", "Staff", "Github", ($scope, $params, $q, $location, Staff, Github) ->
  linkTypes = ["website", "facebook", "plurk", "twitter"]
  $scope.loading = true
  $scope.profile = {}
  $scope.information = {}
  $scope.biography = {}
  $scope.links = []
  $scope.hasError = false

  params = {username: $params.username}

  $q.all({
    profile: (Staff.get(params)).$promise
    information: (Github.info(params)).$promise
    biography: (Github.biography(params)).$promise
  }).then (results) ->
    $scope.loading = false
    $scope.profile = results.profile.user
    $scope.information = results.information
    $scope.biography = results.biography.markdown

    # Load Links
    for linkType in linkTypes
      $scope.links.push(generateLinkObject(linkType, $scope.information[linkType])) if $scope.information[linkType]

  , (error) ->
    $scope.hasError = true
    $scope.error = "喔喔，好像找不到這個人的自我介紹。"

]

