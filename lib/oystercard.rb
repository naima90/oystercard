class Oystercard
  attr_reader :balance, :journey, :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 2

  def initialize
    @balance = 0
  end

  def balance
    @balance
  end

  def top_up(amount)
    raise 'Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station
  end

  def touch_in(station)
    raise "Insufficient balance, Please top up" if @balance < MINIMUM_CHARGE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end
  
  private
  def deduct(amount)
    @balance -= amount
  end
end