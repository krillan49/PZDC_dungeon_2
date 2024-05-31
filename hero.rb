class Hero
  attr_accessor :max_hp_pl, :regen_hp_pl_base, :recovery_hp_pl
  attr_accessor :max_mp_pl, :regen_mp_pl_base, :recovery_mp_pl
  attr_accessor :mindam_pl_base, :maxdam_pl_base
  attr_accessor :accuracy_pl_base, :armor_pl_base
  attr_accessor :exp_pl, :lvl_pl
  attr_accessor :stat_points, :skill_points

  def initialize
    @max_hp_pl = 100
    @regen_hp_pl_base = 0
    @recovery_hp_pl = @max_hp_pl * 0.1

    @max_mp_pl = 100
    @regen_mp_pl_base = 0
    @recovery_mp_pl = @max_mp_pl * 0.1

    @mindam_pl_base = 5
    @maxdam_pl_base = 5

    @accuracy_pl_base = 80
    @armor_pl_base = 0

    @exp_pl = 0
    @lvl_pl = 0

    @stat_points = 5
    @skill_points = 0
  end
end
