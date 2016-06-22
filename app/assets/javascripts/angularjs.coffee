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
        url: '/api/v1/products/:id/add_to_cart'
      }
    }
])

app.factory('OrderItem', ['$resource', ($resource) ->
  $resource '/api/v1/order_items/:id',
    {
      id:'@id'
    }
])


app.controller 'bodyCtrl', ($scope, Order) ->
  $scope.cart = Order.cart()
  
app.controller 'productsCtrl', ($scope, Product) ->
  $scope.init = (products) ->
    $scope.products = products.map (product) ->
      new Product(product)

app.controller 'productCtrl', ($scope, OrderItem) ->

  $scope.add = (product) ->
    oi = new OrderItem(source_id: product.id, source_type: "Product", quantity: product.quantity, order_id: $scope.cart.id)
    console.log(product.quantity)
    oi.$save()
  $scope.selectOp = () ->
    arr = [1..($scope.product.available)]
    return arr
