class Journey

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

end