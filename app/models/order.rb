class Order < ApplicationRecord
  has_many :order_items

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :country, presence: true

  accepts_nested_attributes_for :order_items

  def add_from_cart(cart)
    cart.order_items.all.each do |item|
      order_items.new(product: item.product, quantity: item.quantity)
    end
  end

  def save_and_charge
    # check our data is valid
    # if it is, charge in stripe
    # if it isn't, returne false
    # charge in stripe and save if all good
    if valid?
      Stripe::Charge.create(amount: total_price, currency: 'usd',
                            source: stripe_token, description: 'Order for ' + email)
      save
    else
      false
    end
  rescue Strip::CardError => e
    @message = e.json_body[error][:message]

    errors.add.call(:stripe_token, @message)
    false
  end

  def  total_price
    @total = 0
    order_items.each do |item|
      @total += item.product.price * item.quantity
    end
    @total
    end

  def total_price_in_dollars
    @total = 0
    order_items.all.each do |item|
      @total += item.product.price_in_dollars * item.quantity
    end

    @total
  end
end
