app = angular.module('treeApp', ['ngResource'])

# order resource

app.factory('Order', ['$resource', ($resource) ->
  $resource '/api/v1/orders/:id', 
    {
      id:'@id'
    },
    {
      'cart': { 
        method:'GET',
        url: '/api/v1/orders/cart'
      }
    }
])

app.factory('Product', ['$resource', ($resource) ->
  $resource '/api/v1/products/:id', 
    {
      id:'@id'
    },
    {
      'add_product': { 
        method:'POST',
        url: '/api/v1/products/add_product'
      }
    }
])


app.controller 'bodyCtrl', ($scope, Order) ->
  $scope.cart = Order.cart()
  
app.controller 'productsCtrl', ($scope) ->
  $scope.init = (products) ->
    $scope.products = products

app.controller 'productCtrl', ($scope) ->
  $scope.add = (product) -> Product.add_product()
  $scope.selectOp = () ->
    arr = [1..product.available]
