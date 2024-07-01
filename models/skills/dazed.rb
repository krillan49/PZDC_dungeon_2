class Dazed
  BASIC_MOD = 1
  LVL_MOD = 0.1

  attr_accessor :lvl
  attr_reader :code, :name

  def initialize
    @code = 'dazed'
    @name = "Ошеломление"
    @lvl = 0
  end

  def accuracy_reduce_coef
    BASIC_MOD + LVL_MOD * @lvl
  end

  def accuracy_reduce_percent
    100 / (2 * accuracy_reduce_coef())
  end

  def description
    "(#{@lvl}): если урон больше #{accuracy_reduce_percent().round}% осташихся жизней врага то он теряет 10-90(%) точности"
  end
end











# 
