# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.first)
  end

  def order_email
    @order = Order.where(state: "placed")
    UserMailer.order_email(@order.last.id)
  end
end
