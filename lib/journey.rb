class Journey

 def initialize(name, zone)
   @current_journey = {entry_station: name, entry_zone: zone}
 end

 def see_current_journey
   @current_journey
 end


end