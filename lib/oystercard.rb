class Oystercard

attr_reader :balance, :limit, :in_use


  def initialize(balance = 0)
    @balance = balance
    @limit = 90
    @in_use = false
  end 

  def top_up(money)
    raise "Error: Cannot exceed max balance of #{limit}" if ((@balance + money) > @limit)
    
    @balance += money
  end 

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_use
  end

  def touch_in
    @in_use = true
  end
  
  def touch_out
    @in_use = false
  end

end
