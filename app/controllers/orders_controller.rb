class OrdersController < ApplicationController
    def index
        @orders = Order.all
        render json: @orders
    end

    def create
        @order = Order.new
        @order.store_id = params[:order][:store]
        @order.save
        add_products_order(@order, params[:order][:products])
        @order.update(total: total(@order))

        render json: @order, status: :created
    end

    def show
        @order = Order.find(params[:id])
        render json: @order
    end

    private

    def add_products_order(order, products)
        products.each do |p|
            product = Product.find_by_sku(p[:sku])
            order.order_products.create(product_id: product.id, order_id: order.id, quantity: p[:quantity]) if product
        end
    end

    def total(order)
        total = 0
        if order.order_products.any?
            total = order.order_products.sum { |op| op.product.price * op.quantity }
        end
        total
    end
end
