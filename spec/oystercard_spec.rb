require 'oystercard'
describe Oystercard do

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
    subject.top_up(2)
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'touch out if in journey' do
    subject.top_up(2)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

  it 'raise an error if card with insufficient balance is touched in' do
    expect { subject.touch_in }.to raise_error "Insufficient balance, Please top up"
  end

  it 'deducts correct amount after touch out' do
    subject.top_up(3)
    subject.touch_in
    expect { subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
  end
end