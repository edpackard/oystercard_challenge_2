require_relative "journey"

class Oystercard

MINIMUM_FARE = 1
STARTING_BALANCE = 0
MAX_TOP_UP = 90

attr_reader :balance, 
            :trip,
            :trip_log

  def initialize
    @balance = STARTING_BALANCE
    @trip_log = Array.new
  end 

  def top_up(money)
    error_message = "Error: Cannot exceed max balance of #{MAX_TOP_UP}"
    raise error_message if exceed_top_up?(money, balance)
    
    @balance += money
  end 

  def touch_in(station, zone)
    raise "Insufficient funds!" if insufficient_funds?
    
    if !@trip.nil?
      raise "PENALTY!!" if !@trip.complete?
      
    end
    @trip = Journey.new(station, zone)
    
  end
  
  def touch_out(station, zone)
      raise "PENALTY!!" if @trip.nil? || @trip.complete?
 
    @trip.finish(station, zone)
    deduct(@trip.fare)
    @trip_log << @trip.see_current_journey


  end

  private

  def deduct(money)
    @balance -= money
  end
  
  def exceed_top_up?(amount, balance)
    (balance += amount) > MAX_TOP_UP
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

end
