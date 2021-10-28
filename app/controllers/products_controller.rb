class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_product, only: %i[show edit update destroy]
  skip_after_action :verify_authorized, only: [:show]

  def index
    # @product = product.all
    # Devido as regras do Scope definidas na minha productPolicy
    # essas duas linhas retornam exatamente a mesma coisa
    @products = policy_scope(Product)
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
      redirect_to @product, notice: 'product was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @product
    if @product.update(product_params)
      redirect_to @product, notice: 'product was successfully updated.'
    else
      render :edit
    end
    authorize @product
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to products_url, notice: 'product was successfully destroyed.'
    authorize @product
  end

  def category(category)
    @category = category
    @products = Product.where(category: @category)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :unit, :total_quantity, :price, :category, :photo)
  end
end
