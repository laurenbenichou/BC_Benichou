@bitcoinApp = angular.module('bitcoin_app', ["ngResource"])

# call to the back-end. Json format is
# {
  # cad: float,
  # eur: float,
  # time: hh:mm:ss
# }

@bitcoinApp.factory "Rate", ["$resource", ($resource) ->
  $resource("/home/rates.json", {}, {"query": {method: "GET", isArray: false}})
]

# Get rates when the page loads and every 15 seconds thereafter.

@HomeCtrl = ["$scope", "Rate", ($scope, Rate) ->
  getRates = ->
    $scope.rates = Rate.query()
  getRates()
  setInterval(getRates, 15000)
]

# Intercepts any Ajax requests and show or hide the spinner accordingly

@bitcoinApp.config ($httpProvider) ->
  $httpProvider.responseInterceptors.push "myHttpInterceptor"
  spinnerFunction = spinnerFunction = (data, headersGetter) ->
    $("#spinner-box").show()
    data

  $httpProvider.defaults.transformRequest.push spinnerFunction
  return

@bitcoinApp.factory "myHttpInterceptor", ($q, $window) ->
  (promise) ->
    promise.then ((response) ->
      $("#spinner-box").hide()
      response
    ), (response) ->
      $("#spinner-box").hide()
      $q.reject response