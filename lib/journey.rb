class Journey

PENALTY_FARE = 6

 def initialize(name, zone)
   @current_journey = {entry_station: name, entry_zone: zone}
 end

 def see_current_journey
   @current_journey
 end

 def finish(name, zone)
  @current_journey[:exit_station] = name
  @current_journey[:exit_zone] = zone
 end

 def fare
   return 1 if self.complete?
   PENALTY_FARE
 end
 
 def complete?
   @current_journey.size == 4
 end

end