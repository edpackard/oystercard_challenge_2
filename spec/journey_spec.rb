require 'journey' 

describe Journey do 

subject { described_class.new("name", "zone") }

let (:station) { double :station }

 it "records entry station to journey hash" do
   expect(subject.see_current_journey).to include(entry_station: "name")
 end

 it "records entry station zone to journey hash" do
   expect(subject.see_current_journey).to include(entry_zone: "zone")
 end

end 