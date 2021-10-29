class OrdersController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[index show category]
  before_action :set_order, # only: %i[show edit update destroy]
  skip_after_action :verify_authorized, # only: %i[show category]

  def index
    # @order = order.all
    # Devido as regras do Scope definidas na minha orderPolicy
    # essas duas linhas retornam exatamente a mesma coisa
    @orders = policy_scope(order)
  end

  def show
  end

  def new
    @order = order.new
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
    authorize @order
  end

  def destroy
    authorize @order
    @order.destroy
    redirect_to orders_url, notice: 'Concluído com sucesso: pedido cancelado.'
    authorize @order
  end

  private

  def set_product
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:product_id, :user_id, :quantity, :date, :price)
  end

end
