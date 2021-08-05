require 'journey' 

describe Journey do 

subject { described_class.new("name", "zone") }

let (:station) { double :station }
# When init a new journey instance is created
# we need to save entry and exit info and return

it "when instance called creates a journey hash" do 
  expect(subject.see_journey).to be_a Hash
end 

it "receives entry station name" do
  allow(station).to receive(:see_name).and_return("name")
  expect(subject.see_name).to eq "name"
end

it "receives entry station zone" do
  allow(station).to receive(:see_zone).and_return("zone")
  expect(subject.see_zone).to eq "zone"
end

# HERE IS WHERE WE GOT UP TO \/\/\/
# testing functionality to record journey and then "message" the journey info to the oystercard
# we haven't removed any functionality from the oystercard yet, or brought this functionality into the 
# oystercard - all to do

# it "records entry station to journey hash" do
#   expect(subject.see_journey).to include(entry_station: "name")
# end

# it "records entry station zone to journey hash" do
#   expect(subject.see_journey).to include(entry_zone: "zone")
# end

end 