class Dazed
  BASIC_MOD = 1.2
  LVL_MOD = 0.15

  attr_accessor :lvl
  attr_reader :code, :name

  def initialize
    @code = 'dazed'
    @name = "Dazed"
    @lvl = 0
  end

  def accuracy_reduce_coef
    BASIC_MOD + LVL_MOD * @lvl
  end

  def accuracy_reduce_percent
    100 / (2 * accuracy_reduce_coef())
  end

  def show_cost
    'passive'
  end

  def description
    "If damage is greater #{accuracy_reduce_percent().round}% remaining enemy HP then he loses 10-90% accuracy"
  end

  def description_short
    "If damage is greater some % remaining enemy HP then he loses 10-90% accuracy"
  end
end











#
