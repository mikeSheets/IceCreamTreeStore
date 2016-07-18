class UserMailer < ApplicationMailer
  default from: 'notifications@icecreamtrees.com'

  def welcome_email(user)
    @user = user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: 'Thank you for joining Ice Cream Trees')
  end

  def order_email(order_id)
    @order = Order.find_by(id: order_id)
    @user = User.find_by(id: @order.user_id)
    @credit = CreditCard.find_by(id: @user.id)
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Thank you for your Ice cream tree order')
  end
end