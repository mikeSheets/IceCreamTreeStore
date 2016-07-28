app = angular.module('treeApp')

app.controller 'BodyController', ['$scope', 'Order', 'OrderItem', ($scope, Order, OrderItem) ->
  $scope.cart = Order.cart()

  $scope.cart_check = () ->
    count = 0
    angular.forEach($scope.cart.order_items, (item) ->
      count += parseInt(item.quantity))
    count

  $scope.cart.product_count = $scope.cart_check()

  $scope.add_product = (item) ->
    oi = new OrderItem(source_id: item.id, source_type: "Product", quantity: item.quantity, order_id: $scope.cart.id)
    oi.$save()
    .then (oi2) ->
      if $scope.cart.id?
        looper = true
        angular.forEach($scope.cart.order_items, (item) ->
          if oi2.source.id == item.source.id
            item.quantity = oi2.quantity
            looper = false)
        if looper == true
          $scope.cart.order_items.push(oi2)
      else
        $scope.cart = Order.cart()
      $scope.cart.product_count = $scope.cart_check()
]

app.controller 'ProductsController', ['$scope', 'Product', ($scope, Product) ->
  $scope.init = (products) ->
    $scope.products = products.map (product) ->
      new Product(product)
]

app.controller 'ProductsController', ['$scope', 'Product', ($scope, Product) ->
  $scope.init = (products) ->
    $scope.products = products.map (product) ->
      new Product(product)
]

app.controller 'ProductController', ['$scope', ($scope) ->
  $scope.prod_arr = [0..($scope.product.on_hand)]
]

app.controller 'ItemController', ['$scope', ($scope) ->
  $scope.price = ($scope.item.quantity*$scope.item.source.price)
  $scope.arr = [0..($scope.item.source.on_hand)]
]

app.controller 'CartController', ['$scope', 'Product', 'OrderItem', ($scope, Product, OrderItem) ->
  $scope.init = (products) ->
    $scope.products = products.map (product) ->
      new Product(product)

  $scope.total = () ->
    tot = 0
    angular.forEach($scope.cart.order_items, (item) ->
      tot += (item.quantity*item.source.price))
    tot

  $scope.add_product = (item) ->
    oi = new OrderItem(source_id: item.source.id, source_type: "Product", quantity: item.quantity, order_id: $scope.cart.id)
    oi.$save()
    .then (oi2) ->
      looper = true
      angular.forEach($scope.cart.order_items, (item) ->
        if oi2.source.id == item.source.id
          item.quantity = oi2.quantity
          looper = false)
      if looper == true
        $scope.cart.order_items.push(oi2)
      $scope.cart.product_count = $scope.cart_check()
]

app.controller 'CheckoutController', ['$scope', '$window', '$q', 'Order', 'Cc', 'Product', 'Address', 'State', ($scope, $window, $q, Order, Cc, Product, Address, State) ->
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
        $scope.order_errors = $scope.strip(errors.data)

  $scope.updateAddress = () ->
    if $scope.address.id?
      promise = $scope.address.$update()
      delete $scope.address_errors
    else
      promise = $scope.address.$save()
      delete $scope.address_errors

    promise.then () ->
      $scope.order.address_id = $scope.address.id
      delete $scope.address_errors
    promise.catch (errors) ->
      $scope.address_errors = $scope.strip(errors.data)

  $scope.updateBilling = () ->
    if $scope.cc.id?
      promise = $scope.cc.$update()
      delete $scope.cc_errors
    else
      promise = $scope.cc.$save()
      delete $scope.errors

    promise.then ()->
      $scope.order.credit_card_id = $scope.cc.id
      delete $scope.cc_errors
    promise.catch (errors) ->
      $scope.cc_errors = $scope.strip(errors.data)

  $scope.strip = (clothes) ->
    clean_errors = {}
    angular.forEach clothes, (errors, key) ->
      clean_errors[key.charAt(0).toUpperCase() + key.substr(1).toLowerCase()] = errors.join(", ")
    clean_errors
]