class Dazed
  HP_PART_BASIC_MOD = 1.2
  HP_PART_LVL_MOD = 0.15
  ACC_MAX_REDUCE = 90
  ACC_MIN_REDUCE = 10
  ACC_MIN_REDUCE_LVL_MOD = 3

  attr_accessor :lvl
  attr_reader :entity_type, :code, :name

  def initialize
    @entity_type = 'skills'
    @code = 'dazed'
    @name = "Dazed"
    @lvl = 0
  end

  def accuracy_reduce_minimum
    [ACC_MIN_REDUCE + ACC_MIN_REDUCE_LVL_MOD * @lvl, ACC_MAX_REDUCE].min
  end

  def accuracy_reduce_coef
    0.01 * (100 - rand(accuracy_reduce_minimum()..ACC_MAX_REDUCE))
  end

  def hp_part_coef
    HP_PART_BASIC_MOD + HP_PART_LVL_MOD * @lvl
  end

  def show_cost
    'passive'
  end

  def description
    "If damage is greater #{hp_part_percent().round}% remaining enemy HP then he loses #{accuracy_reduce_minimum()}-#{ACC_MAX_REDUCE}% accuracy"
  end

  def description_short
    "If damage is greater some % remaining enemy HP then he loses up to 90% accuracy"
  end

  private

  def hp_part_percent
    100 / (2 * hp_part_coef())
  end

end











#
