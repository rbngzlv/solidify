module SolidusLiquid
  class OrdersController < LiquidController
    # Adds a new item to the order (creating a new order if none already exists)
    def populate
      @order   = current_order(create_order_if_necessary: true)
      variant  = Spree::Variant.find(params[:id])

      begin
        @line_item = @order.contents.add(variant, params[:quantity])
      rescue ActiveRecord::RecordInvalid => e
        @order.errors.add(:base, e.record.errors.full_messages.join(", "))
      end

      redirect_to cart_path
    end

    def set_liquid_assigns
      @liquid_assigns = {}
    end
  end
end