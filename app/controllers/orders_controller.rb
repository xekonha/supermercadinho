class OrdersController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[index show category]
  # before_action :set_product, only: %i[show edit update destroy]
  # skip_after_action :verify_authorized, only: %i[show category my]
  # skip_before_action :authenticate_user!, only: %i[index show category]
  # before_action :set_order # only: %i[show edit update destroy]
  # skip_after_action :verify_authorized

  def index
    # @order = order.all
    # Devido as regras do Scope definidas na minha orderPolicy
    # essas duas linhas retornam exatamente a mesma coisa
    @orders = Order.where(user: current_user, completed: false)
  end

  def show
  end

  def new
    @order = Order.new(user: current_user, completed: false)
    authorize @order
  end

  def edit
    # Código utilizado como exemplo de uma autorização
    # utilizando o 'Devise'
    # NÃO FAZEMOS ISSO. Utilizamos o 'Pundit'
    # unless @order.user == current_user
    #   redirect_to orders_path
    # end
    authorize @order
  end

  def create
    @order = order.new(order_params)
    @order.user = current_user
    authorize @order
    if @order.save
      redirect_to :back, notice: 'Concluído: produto incluído no carrinho.'
    else
      redirect_to :root
    end
  end

  def destroy
    authorize @order
    @order.destroy
    redirect_to :back, notice: 'Concluído: produto excluído do carrinho.'
  end

  private

  def order_params
    params.require(:order).permit(:product_id, :user_id, :quantity, :date)
  end
end
