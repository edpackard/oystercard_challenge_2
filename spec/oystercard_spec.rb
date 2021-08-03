require "oystercard"

describe Oystercard do 

  let (:station) { double :station }

  subject(:oystercard) { described_class.new }
  
  it { is_expected.to respond_to(:top_up).with(1).argument } 
  
  it { expect(subject.balance).to eq(Oystercard::STARTING_BALANCE) }

  describe '#top_up' do
    it "adds money to card" do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it "limits our balance to max £90" do
      subject.top_up(Oystercard::MAX_TOP_UP)
      expect { subject.top_up(5) }.to raise_error "Error: Cannot exceed max balance of 90"
    end
  end

  describe "#in_journey?" do
    it "returns true if in_journey" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(:station)
      expect(subject.in_journey?).to be true
    end
    
    it "returns false if not in_journey" do
      expect(subject.in_journey?).to be false
    end
  end

  describe "#touch_in" do
    it "changes in_journey? status to true" do
      subject.top_up(Oystercard::MINIMUM_FARE*2)
      subject.touch_out(:station)
      expect { subject.touch_in(:station) }.to change { subject.in_journey? }.to(true)
    end

    it "raises an error if insufficient funds" do
      expect { subject.touch_in(:station) }.to raise_error "Insufficient funds!"
    end

    it "remembers station after touch_in" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(:station)
      expect(subject.entry_station).to eq :station
    end
  end

  describe "#touch_out" do
    it "sets in_journey? status to false" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.in_journey?).to eq false
    end
  
    it "deducts minimum fare" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      expect { subject.touch_out(:station ) }.to change{subject.balance}.by (-Oystercard::MINIMUM_FARE)
    end

    it "resets entry station to nil after touch out" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(:station)
      expect { subject.touch_out(:station) }.to change{subject.entry_station}.to nil
    end
    it "remembers station after touch_out" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_out(:station)
      expect(subject.exit_station).to eq :station
    end

  end


end
