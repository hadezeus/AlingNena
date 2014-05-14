class MoneyCalculator

  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
		@ones = ones.to_i
		@fives	= fives.to_i
		@tens = tens.to_i
		@twenties	= twenties.to_i
		@fifties	= fifties.to_i
		@hundreds	= hundreds.to_i
		@five_hundreds = five_hundreds.to_i
		@thousands = thousands.to_i
  end

	def change(price)
		@payment = @ones + @fives*5 + @tens*10 + @twenties*20 + @fifties*50 + @hundreds*100 + @five_hundreds*500 + @thousands*1000
	end
end
