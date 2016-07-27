class UserMailer < ApplicationMailer
  default from: 'notifications@icecreamtrees.com'
  include SendGrid

  def welcome_email(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Thank you for joining Ice Cream Trees')
  end

  def order_email(order_id)
    @order = Order.find_by(id: order_id)
    @user = @order.user
    @credit = @order.payment.credit_card
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Thank you for your Ice cream tree order')
  end
end