require "oystercard"

describe Oystercard do 
  subject(:oystercard) { described_class.new }
  it { is_expected.to respond_to(:top_up).with(1).argument } 
  it { expect(subject.balance).to eq(0) }


  describe '#top_up' do
    it "adds money to card" do
     expect(subject.top_up(5)).to eq(5)
    end
    it "limits our balance to max £90" do
      expect { Oystercard.new(90).top_up(5) }.to raise_error "Error: Cannot exceed max balance of 90"
    end
  end

  describe 'deduct' do
    it "deducts money from card" do
      expect(Oystercard.new(10).deduct(5)).to eq(5)
    end
  end

  describe "in_journey" do
    it "returns true if in_journey" do
    subject.touch_in
    expect(subject.in_journey?).to be true
    end
    it "returns false if not in_journey" do
      expect(subject.in_journey?).to be false
    end
  end

  describe "#touch_in" do

    it "changes in_journey? status to true" do
      expect { subject.touch_in }. to change { subject.in_journey? }.to(true)
    end
  end

  describe "#touch_out" do
    it "sets in_journey? status to false" do
      subject.touch_in
      subject.touch_out
    expect(subject.in_journey?).to eq false
    end
  end

end