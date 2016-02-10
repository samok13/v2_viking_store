class ProductsController < ApplicationController

  def index
    @products = Product.all.order("id")
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "#{@product.name} was successfully created."
      redirect_to product_path(@product)
    else
      flash.now[:error] = "Error! Product wasn't created!"
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "#{@product.name} was successfully updated."
      redirect_to product_path(@product)
    else
      flash.now[:error] = "Error! Product wasn't updated!"
      render :edit
    end
  end

  def destroy
     @product = Product.find(params[:id])
    if @product.destroy
      flash[:success] = "You've Sucessfully Deleted #{@product.name}!"
      redirect_to products_path
    else
      flash.now[:error] = "Error! Product wasn't deleted!"
      render :show
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :sku, :price, :category_id)
  end
end
