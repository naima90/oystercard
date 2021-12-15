require 'oystercard'
describe Oystercard do
  let(:station){ double :station, :name => "London Bridge", :zone => 1 }
  let(:station_two){ double :station_two, :name => "Camden Town", :zone => 1 }
  
  def top_up_touch_in 
    subject.top_up(3)
    subject.touch_in(station)
  end
  def top_up_touch_out 
    subject.top_up(3)
    subject.touch_in(station)
    subject.touch_out(station_two)
  end

  it 'card needs to have a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up card balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end

  it 'raises an error if the maximum balance is exceeded' do
    limit = Oystercard::MAXIMUM_BALANCE
    subject.top_up(limit)
    expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded'
  end

  it 'its not in a journey' do
    expect(subject).not_to be_in_journey
  end

  it "touch in if not in journey" do
    top_up_touch_in 
    expect(subject).to be_in_journey
  end

  it 'touch out if in journey' do
    top_up_touch_out 
    expect(subject).not_to be_in_journey
  end

  it 'raise an error if card with insufficient balance is touched in' do
    expect { subject.touch_in(station) }.to raise_error "Insufficient balance, Please top up"
  end

  it 'deducts correct amount after touch out' do
    top_up_touch_in
    expect { subject.touch_out(station_two) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
  end

  it 'remembers the entry station after touch in' do
    top_up_touch_in
    expect(subject.entry_station).to eq station
  end
  
  it 'checks a list of empty journeys at the start' do
    expect(subject.journey_log).to eq []
  end

  it 'saves all previous stations' do
    top_up_touch_out
    expect(subject.journey_log).to eq [{station_in: "London Bridge", zone_in: 1, station_out: "Camden Town", zone_out: 1}]
  end
end