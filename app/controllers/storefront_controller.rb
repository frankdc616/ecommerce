class StorefrontController < ApplicationController
  def all_items
  	@products = Product.all
  	@categories = Category.all
  end

  def items_by_category
  	@category = Category.find(params[:cat_id])
  	products = Product.all

  	@products = []

  	products.each do |product|
  		if product.category_id == @category.id
  			@products.push(product)
  		end
  	end

  end

  def items_by_brand
  	# @brand_name = params[:brand]
  	# products = Product.all

  	# @products = []

  	# products.each do |product|
  	# if product.brand == @brand_name
  	# 	@products.push(product)

  	@products = Product.where(brand: params[:brand])
  	@brand_name = params[:brand]


  end
end










