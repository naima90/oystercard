require 'oystercard'
describe Oystercard do

  it 'card needs to have a balance of 0' do
    expect(subject.balance).to eq 0
  end
end