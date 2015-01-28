module Api
  module V1
    class TradesController < ApplicationController
      before_action :authenticate_api
      before_action :set_trade, only: [:update, :destroy]

      def index
        @trades = current_user.trades || []
        render
      end

      def create
        @trade = current_user.trades.build(trade_params)
        @trade.save!
        render status: :created
      end

      def update
        @trade.update!(trade_params)
        head :no_content
      end

      def destroy
        @trade.destroy
        head :no_content
      end

      private

      def trade_params
        params.require(:trade).permit(:amount, :trade_at, :memo, :category_id)
      end

      def set_trade
        @trade = Trade.find(params[:id])
      end
    end
  end
end
