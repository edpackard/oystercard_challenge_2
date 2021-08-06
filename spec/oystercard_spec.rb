require "oystercard"

describe Oystercard do 

  let (:station) { double :station }
  let (:station2) { double :station2 }

  describe "initialized instance variables" do
    it "initializes starting balance as a constant" do
      expect(subject.balance).to eq Oystercard::STARTING_BALANCE
    end
    it "initializes @journeys as empty" do
      expect(subject.trip_log).to be_empty
    end
  end

  describe '#top_up' do
    it "adds money to card" do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it "limits balance to a maximum constant" do
      subject.top_up(Oystercard::MAX_TOP_UP)
      expect { subject.top_up(5) }.to raise_error "Error: Cannot exceed max balance of 90"
    end
  end

  describe "#touch_in" do

  before(:each) do
    allow(station).to receive(:get_name).and_return("name")
    allow(station).to receive(:get_zone).and_return("zone")
  end

    context "no funds" do
     
      it "raises an error if insufficient funds" do
        name = station.get_name
        zone = station.get_zone
        expect { subject.touch_in(name, zone) }.to raise_error "Insufficient funds!"
      end
    end
    
    context "with funds" do
      before(:each) do
        subject.top_up(Oystercard::MINIMUM_FARE)
        subject.touch_in("name", "zone")
      end

      it 'tests touching in on incomplete journey incurs penalty fare' do
        expect { subject.touch_in("Holborn","1") }.to change { subject.balance }.by (-6)
      end

      it 'test touching in on an incomplete journey sends penalty message to trip log' do
        subject.touch_in("Holborn", "1")
        expect(subject.trip_log).to contain_exactly({penalty: "Holborn"})
      end

    end
  end

  describe "#touch_out" do

    context "check min fare" do

      it "deducts minimum fare" do
        subject.top_up(Oystercard::MINIMUM_FARE)
        subject.touch_in("Mile End", "2")
        expect { subject.touch_out("Holborn","1") }.to change { subject.balance }.by (-Oystercard::MINIMUM_FARE)
      end

    end

    context "check journey" do
    
      before(:each) do
        subject.top_up(Oystercard::MINIMUM_FARE)
        allow(station).to receive(:get_name).and_return("name")
        allow(station).to receive(:get_zone).and_return("zone")
        subject.touch_in("name", "zone")
        subject.touch_out("name","zone")
      end
      
      it "adds journey data to journeys array" do
        hash = {entry_station: "name", exit_station: "name", entry_zone: "zone", exit_zone: "zone"}
        expect(subject.trip_log).to contain_exactly(hash)
      end
      
      it 'tests touching out when not touching in first raises penalty' do
        expect { subject.touch_out("name", "zone") }.to raise_error "PENALTY!!"
      end
      
    end
    
    context "Touch_out penalty" do
      
       it 'tests touching out when not touching in first raises penalty, on a new card' do
        expect { subject.touch_out("name", "zone") }.to raise_error "PENALTY!!"
      end
      
    end
  end

end
