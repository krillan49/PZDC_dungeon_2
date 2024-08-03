class TreasureHunter
  BASIC_MOD = 50
  LVL_MOD = 5

  attr_accessor :lvl
  attr_reader :code, :name

  def initialize
    @code = 'treasure_hunter'
    @name = "Treasure hunter"
    @lvl = 0
  end

  def coeff_lvl
    BASIC_MOD + LVL_MOD * @lvl
  end

  def description
    "(#{@lvl}): treasure hunt bonus is #{coeff_lvl()}"
  end
end













#
