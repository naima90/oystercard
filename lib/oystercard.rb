class Oystercard
  attr_reader :balance

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

  def balance
    @balance
  end

  def top_up(amount)
    raise 'Maximum balance of #{limit} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end
  
  def deduct(amount)
    @balance -= amount
  end
end