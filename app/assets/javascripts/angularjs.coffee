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
        url: '/api/v1/products/:id/add_product'
      }
    }
])

app.factory('OrderItem', ['$resource', ($resource) ->
  $resource '/api/v1/order_items/:id',
    {
      id:'@id'
    }
])


app.controller 'bodyCtrl', ($scope, Order, OrderItem) ->
  $scope.cart = Order.cart()

  $scope.add_product = (item) ->
    oi = new OrderItem(source_id: item.source.id, source_type: "Product", quantity: item.quantity, order_id: $scope.cart.id)
    oi.$save()
    count = 0
    angular.forEach $scope.cart.order_items, (item) ->
      count += parseInt(item.quantity)
    $scope.cart.product_count = count


app.controller 'productsCtrl', ($scope, Product) ->
  $scope.init = (products) ->
    $scope.products = products.map (product) ->
      new Product(product)

app.controller 'productCtrl', ($scope) ->
  $scope.selectOp = () ->
    arr = [1..($scope.product.available)]
    return arr




app.controller 'cartCtrl', ($scope, Product) ->
  $scope.init = (products) ->
    $scope.products = products.map (product) ->
      new Product(product)
  $scope.total = () ->
    tot = 0
    angular.forEach($scope.cart.order_items, (item) ->
      tot += (item.quantity*item.source.price))
    tot

app.controller 'itemCtrl', ($scope) ->
  $scope.price = ($scope.item.quantity*$scope.item.source.price)

  $scope.selectOp = () ->
    arr = [1..($scope.item.source.available)]
    return arr

