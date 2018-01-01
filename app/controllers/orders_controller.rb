class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(form_params)
  end

  if @order.save
    redirect_to order_path(@order)
  else
    render 'new'
  end
end
