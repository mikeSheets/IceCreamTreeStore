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

app.controller 'ItemController', ($scope) ->
  $scope.price = ($scope.item.quantity*$scope.item.source.price)
  $scope.arr = [0..($scope.item.source.on_hand)]

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

app.controller 'CheckoutController', ($scope, Order, Cc, Product, $window, $q, Address, State) ->
  Order.cart().$promise.then (order) ->
    $scope.order = order

  $scope.cc_init = (credit) ->
    if credit?
      $scope.cc = new Cc(credit)
    else
      $scope.cc = new Cc()

  $scope.states = State.query()
  $scope.address_init = (feed) ->
    if feed?
      $scope.address = new Address(feed)
    else
      $scope.address = new Address()

  $scope.place_order = () ->
    if $scope.placing_order
      return
    $scope.placing_order = true

    promises = []
    if !$scope.address.id?
      promises.push $scope.updateAddress()
    if !$scope.cc.id?
      promises.push $scope.updateBilling()
    $q.all(promises)
    .then ->
      $scope.order.address_id = $scope.address.id
      $scope.order.credit_card_id = $scope.cc.id
      $scope.order.state = 'placed'
      order = new Order($scope.order)
      $scope.order.$update()
      .then (order) ->
        $window.location.href = "/orders/#{order.id}"
      .catch (errors) ->
        $scope.placing_order = false
        console.log errors

  $scope.updateAddress = () ->
    if $scope.address.id?
      promise = $scope.address.$update()
    else
      promise = $scope.address.$save()

    promise.then () ->
      $scope.$parent.order.address_id = $scope.address.id
      delete $scope.errors
    .catch (errors) ->
      $scope.address_errors = errors.data

  $scope.updateBilling = () ->
    if $scope.cc.id?
      promise = $scope.cc.$update()
    else
      promise = $scope.cc.$save()

    promise.then ()->
      $scope.$parent.order.credit_card_id = $scope.cc.id
    promise.catch (errors) ->
      $scope.cc_errors = errors