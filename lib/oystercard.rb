class Oystercard
  attr_reader :balance, :journey, :entry_station, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 2
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey_log = []
    @journey_hash = {}
  end

  def balance
    @balance
  end

  def top_up(amount)
    raise 'Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @journey_hash[:station_in]
  end

  def touch_in(station)
    raise "Insufficient balance, Please top up" if @balance < MINIMUM_CHARGE
    deduct(PENALTY_FARE) if @journey_hash[:station_in]
    @journey_hash = { station_in: station.name, zone_in: station.zone, station_out: nil, zone_out: nil }
  end

  def touch_out(station)
    @journey_hash[:station_out], @journey_hash[:zone_out] = station.name, station.zone
    @journey_hash[:station_in] ? deduct(MINIMUM_CHARGE) : deduct(PENALTY_FARE) 
    @journey_log << @journey_hash
    @journey_hash = {}
  end
  
  private
  def deduct(amount)
    @balance -= amount
  end
end