class Oystercard

MINIMUM_FARE = 1
STARTING_BALANCE = 0
MAX_TOP_UP = 90

attr_reader :balance, 
            :journey,
            :journeys

  def initialize
    @balance = STARTING_BALANCE
    @journeys = Array.new
  end 

  def top_up(money)
    error_message = "Error: Cannot exceed max balance of #{MAX_TOP_UP}"
    raise error_message if exceed_top_up?(money, balance)
    
    @balance += money
  end 

  def in_journey?
    @journey.size == 2
    #alternative: @entry_station != nil ? true : false
  end
   # NEED TO MOVE ^^

  def touch_in(station, zone)
    raise "Insufficient funds!" if insufficient_funds?
    @journey = Hash.new
    record_journey(:entry_station, station)
    record_journey(:entry_zone, zone)
    # NEED TO MOVE ^^
  end
  
  def touch_out(station, zone)
    deduct(MINIMUM_FARE)
    record_journey(:exit_station, station)
    record_journey(:exit_zone, zone)
    # NEED TO MOVE ^^
    @journeys << @journey
  end

  private

  def deduct(money)
    @balance -= money
  end

  def record_journey(key, value)
    @journey[key] = value
  end
   # NEED TO MOVE ^^

  def exceed_top_up?(amount, balance)
    (balance += amount) > MAX_TOP_UP
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

end
