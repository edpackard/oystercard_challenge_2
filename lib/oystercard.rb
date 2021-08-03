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

  def in_journey?(status = false)
    @in_use = status
  end

end
