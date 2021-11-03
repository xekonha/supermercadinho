class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show category]
  before_action :set_product, only: %i[show edit update destroy]
  skip_after_action :verify_authorized, only: %i[show category my]

  def index
    # @product = product.all
    # Devido as regras do Scope definidas na minha productPolicy
    # essas duas linhas retornam exatamente a mesma coisa
    @products = policy_scope(Product.order(:name.downcase))
  end

  def show
  end

  def new
    @product = Product.new
    authorize @product
  end

  def edit
    # Código utilizado como exemplo de uma autorização
    # utilizando o 'Devise'
    # NÃO FAZEMOS ISSO. Utilizamos o 'Pundit'
    # unless @product.user == current_user
    #   redirect_to products_path
    # end
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product
    if @product.save
      redirect_to @product, notice: 'Produto cadastrado com sucesso.'
    else
      render :new
    end
  end

  def update
    authorize @product
    if @product.update(product_params)
      redirect_to @product, notice: 'Produto atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to products_url, notice: 'Produto removido com sucesso.'
  end

  def category
    @products = Product.order(:name.downcase).where(category: params[:format])
  end

  def my
    @products = current_user.products
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :unit, :total_quantity, :price, :category, :photo)
  end
end
