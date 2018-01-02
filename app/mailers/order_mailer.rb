class OrderMailer < ApplicationMailer
  def receipt(order)
    @order = order

    mail to: @order.email, subject: 'Thank you for ordering form Another Pin Co'
  end
end
