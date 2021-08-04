require 'station'

describe Station do

  subject { described_class.new(:name, :zone) }

  it "creates/stores name" do
    expect(subject.name).to eq(:name)
  end

  it "creates/stores zone" do
    expect(subject.zone).to eq(:zone)
  end

end
