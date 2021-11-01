class OrdersController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_order, only: %i[edit update destroy]
  # skip_after_action :verify_authorized, only: %i[show]

  def index
    # @order = order.all
    # Devido as regras do Scope definidas na minha orderPolicy
    # essas duas linhas retornam exatamente a mesma coisa
    @orders = policy_scope(Order)
  end

  def show
  end

  def new
    @order = Order.new
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
      redirect_to @order, notice: 'Concluído com sucesso: pedido criado.'
    else
      render :new
    end
  end

  def update
    authorize @order
    if @order.update(order_params)
      redirect_to @order, notice: 'Concluído com sucesso: pedido atualizado.'
    else
      render :edit
    end
  end

  def destroy
    authorize @order
    @order.destroy
    redirect_to orders_url, notice: 'Concluído com sucesso: pedido cancelado.'
  end

  private

  def set_product
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:product_id, :user_id, :quantity, :date)
  end

end
