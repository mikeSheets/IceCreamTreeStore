# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.coffee.
# You can use CoffeeScript in this file: http://coffeescript.org/

$( document ).ready ->
  $(".add_to_cart").on "click", ->
    $t = $(this)
    qty = $t.parents(".product").find('option:selected').val()

    qty = parseInt(qty)

    if !qty? or qty <= 0
      false
    else
      params = $t.data("params")
      params.quantity = qty
      $t.data("params", params)