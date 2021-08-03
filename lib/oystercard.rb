class Oystercard

MINIMUM_FARE = 1
STARTING_BALANCE = 0
MAX_TOP_UP = 90

attr_reader :balance, :in_use

  def initialize
    @balance = STARTING_BALANCE
    @in_use = false
  end 

  def top_up(money)
    raise "Error: Cannot exceed max balance of #{MAX_TOP_UP}" if ((@balance + money) > MAX_TOP_UP)
    
    @balance += money
  end 

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise "Insufficient funds!" if @balance < MINIMUM_FARE
    @in_use = true
  end
  
  def touch_out
    @in_use = false
  end

end
