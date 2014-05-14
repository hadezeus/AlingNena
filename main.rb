require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

get '/' do
	@products = Item.all.sample(10)
	erb :index
end

get '/about' do
	erb :about
end

get '/products' do
	@products = Item.where.not(quantity: 0)
	erb :products
end

get '/purchase/:id' do
	@product = Item.find(params[:id])
	erb :buyform
end

post '/purchase/:id' do
	@product = Item.find(params[:id])
	@amount = params[:amount].to_i
	@changer = MoneyCalculator.new(params[:ones], params[:fives], params[:tens], params[:twenties], params[:fifties], params[:hundreds], params[:five_hundreds], params[:thousands])
	@ones = params[:ones].to_i
	@fives	= params[:fives].to_i
	@tens = params[:tens].to_i
	@twenties	= params[:twenties].to_i
	@fifties	= params[:fifties].to_i
	@hundreds	= params[:hundreds].to_i
	@five_hundreds = params[:five_hundreds].to_i
	@thousands = params[:thousands].to_i
	@payment = @ones + @fives*5 + @tens*10 + @twenties*20 + @fifties*50 + @hundreds*100 + @five_hundreds*500 + @thousands*1000
	@change = @payment - @product.price*@amount
	@product.update_attributes!(
    name: @product.name,
    price: @product.price,
    quantity: @product.quantity - params[:amount].to_i,
    sold: @product.sold + params[:amount].to_i,
  )
		erb :transact
end

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
	@item = Item.new
	@item.name = params[:name]
	@item.price = params[:price]
	@item.quantity = params[:quantity]
	@item.sold = 0
	@item.save
 	redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION
