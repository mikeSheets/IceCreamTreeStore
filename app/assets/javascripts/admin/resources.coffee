app = angular.module('treeApp')

app.factory('Order', ['$resource', ($resource) ->
  $resource '/api/v1/orders/:id', { id: "@id" },
    'update': {
      method: 'PUT'
      url: '/api/v1/orders/:id'
    },
    'cart': {
      method: 'GET'
      isArray: false
      url: '/api/v1/orders/cart'
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

app.factory('Address', ['$resource', ($resource) ->
  $resource '/api/v1/addresses/:id',
    {
      id: '@id'
    },
    {
      'update': {
        method: 'PUT',
        url: '/api/v1/addresses/:id'
      }
    }
])

app.factory('State', ['$resource', ($resource, $options) ->
  $resource '/api/v1/states'
])

app.factory('Cc', ['$resource', ($resource) ->
  $resource '/api/v1/credit_cards/:id',
    {
      id: '@id'
    },
    {
      'update': {
        method: 'PUT',
        url: '/api/v1/credit_cards/:id'
      }
    }
])