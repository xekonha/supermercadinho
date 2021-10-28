class OrdersController < ApplicationController
  def index
  # @order = order.all
  # Devido as regras do Scope definidas na minha orderPolicy
  # essas duas linhas retornam exatamente a mesma coisa
  @orders = policy_scope(Order)
  end

  def show
    authorize @order
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
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    authorize @order

    if @order.save
      redirect_to @order, notice: 'order was successfully created.'
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'order was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'order was successfully destroyed.'
  end

  private

  def set_order
    @order = Order.find(params[:id])
    authorize @order
  end

  def order_params
    params.require(:order).permit(:quantity, :date)
  end
end
