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
    expect{ subject.top_up 1 }.to raise_error 'Maximum balance of #{limit} exceeded'
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'reduces balance by the specified amount' do
      subject.top_up(10)
      expect{ subject.deduct 2}.to change{ subject.balance}.by -2
    end
  end
end