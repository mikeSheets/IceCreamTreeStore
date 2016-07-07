app = angular.module('treeApp')

app.controller 'BodyController', ($scope, Order, OrderItem) ->
  $scope.cart = Order.cart()

#  This add_product uses item.id for the product page.
  $scope.add_product = (item) ->
    if item.quantity == 0
      $scope.remove = (item) ->
        oi = new OrderItem(source_id: item.id, source_type: "Product", quantity: item.quantity, order_id: $scope.cart.id)
        oi.$save()
        oi.$delete()

    oi = new OrderItem(source_id: item.id, source_type: "Product", quantity: item.quantity, order_id: $scope.cart.id)
    oi.$save()
    count = 0
    angular.forEach $scope.cart.order_items, (item) ->
      count += parseInt(item.quantity)
    $scope.cart.product_count = count

app.controller 'ProductsController', ($scope, Product) ->
  $scope.init = (products) ->
    $scope.products = products.map (product) ->
      new Product(product)

app.controller 'ProductController', ($scope) ->
  $scope.prod_arr = [0..($scope.product.on_hand)]

app.controller 'CartController', ($scope, Product, OrderItem) ->
  $scope.init = (products) ->
    $scope.products = products.map (product) ->
      new Product(product)

  $scope.total = () ->
    tot = 0
    angular.forEach($scope.cart.order_items, (item) ->
      tot += (item.quantity*item.source.price))
    tot

#   This add_product is used for the cart page and uses item.source.id
  $scope.add_product = (item) ->
    if item.quantity == 0
      $scope.remove_item = (item) ->
        oi = new OrderItem(source_id: item.source.id, source_type: "Product", quantity: item.quantity, order_id: $scope.cart.id)
        oi.$save()
        oi.$delete()
    oi = new OrderItem(source_id: item.source.id, source_type: "Product", quantity: item.quantity, order_id: $scope.cart.id)
    oi.$save()
    count = 0
    angular.forEach $scope.cart.order_items, (item) ->
      count += parseInt(item.quantity)
    $scope.cart.product_count = count

app.controller 'ItemController', ($scope) ->
  $scope.price = ($scope.item.quantity*$scope.item.source.price)
  $scope.arr = [0..($scope.item.source.on_hand)]

app.controller 'AddressController', ($scope, Address, State) ->
  $scope.states = State.query()
  $scope.address_init = (feed) ->
    if feed?
      $scope.address = new Address(feed)
    else
      $scope.address = new Address()
  $scope.updateAddress = () ->
    if $scope.address.id?
      promise = $scope.address.$update()
    else
      promise = $scope.address.$save()

    promise.then (address) ->
      $scope.$parent.order.address_id = address.id

    .catch (errors) ->
      $scope.errors = errors

app.controller 'CreditCardController', ($scope, Cc) ->
  $scope.cc_init = (credit) ->
    if credit?
      $scope.cc = new Cc(credit)
    else
      $scope.cc = new Cc()
  $scope.updateBilling = () ->
    if $scope.cc.id?
      promise = $scope.cc.$update()
    else
      promise = $scope.cc.$save()
    promise.catch (errors) ->
      $scope.errors = errors

app.controller 'CheckoutController', ($scope, Order, Cc, Product, $window) ->
  Order.cart().$promise.then (order) ->
    $scope.order = order

  $scope.place_order = () ->
    if $scope.placing_order
      return
    $scope.placing_order = true

    $scope.order.state = 'placed'
    order = new Order($scope.order)
    $scope.order.$update().then (order) ->
      $scope.placing_order = false
      $window.location.href = "/orders/#{order.id}"
    .catch (errors) ->
      console.log errors