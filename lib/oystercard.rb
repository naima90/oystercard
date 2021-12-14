class Oystercard
  attr_reader :balance, :journey

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
  
  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @journey
  end

  def touch_in
    raise "Insufficient balance, Please top up" if @balance < 1
    @journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @journey = false
  end
end