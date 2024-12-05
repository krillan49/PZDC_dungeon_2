class TreasureHunter
  BASIC_MOD = 50
  LVL_MOD = 10

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

  def show_cost
    'passive'
  end

  def description
    "Positively affects many random actions in the game. Luck bonus is #{coeff_lvl()}"
  end

  def description_short
    "Positively affects many random actions in the game"
  end
end













#
