class ShieldMaster
  BASIC_CHANCE_MOD = 10
  LVL_CHANCE_MOD = 2

  attr_accessor :lvl
  attr_reader :code, :name

  def initialize
    @code = 'shield_master'
    @name = "Shield master"
    @lvl = 0
  end

  def block_chance_bonus
    BASIC_CHANCE_MOD + LVL_CHANCE_MOD * @lvl
  end

  def show_cost
    'passive'
  end

  def description
    "Shield block chance increased by #{block_chance_bonus()}%"
  end

  def description_short
    "Shield block chance increased by #{block_chance_bonus()}%"
  end
end















#
