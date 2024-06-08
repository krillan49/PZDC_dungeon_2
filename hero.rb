require 'yaml'
require_relative 'weapons'

class Hero
  attr_accessor :name_pl
  attr_reader :background
  attr_accessor :hp_max_pl, :hp_pl, :regen_hp_base_pl, :regen_hp_pl, :recovery_hp_pl
  attr_accessor :mp_max_pl, :mp_pl, :regen_mp_base_pl, :regen_mp_pl, :recovery_mp_pl
  attr_accessor :mindam_base_pl, :mindam_pl, :maxdam_base_pl, :maxdam_pl
  attr_accessor :accuracy_base_pl, :accuracy_pl
  attr_accessor :armor_base_pl, :armor_pl
  attr_accessor :block_pl
  attr_accessor :exp_pl, :lvl_pl
  attr_reader :exp_lvl
  attr_accessor :stat_points, :skill_points
  attr_accessor :weapon

  def initialize(background)
    hero = YAML.safe_load_file('data/characters/heroes.yml', symbolize_names: true)[background.to_sym]

    @background = hero[:name]

    @hp_pl = hero[:hp]
    @hp_max_pl = hero[:hp]
    @regen_hp_base_pl = 0
    @recovery_hp_pl = @hp_max_pl * 0.1

    @mp_pl = hero[:mp]
    @mp_max_pl = hero[:mp]
    @regen_mp_base_pl = 0
    @recovery_mp_pl = @mp_max_pl * 0.1

    @mindam_base_pl = hero[:min_dmg]
    @maxdam_base_pl = hero[:max_dmg]

    @accuracy_base_pl = hero[:accurasy]

    @armor_base_pl = hero[:armor]

    @exp_pl = 0
    @lvl_pl = 0
    @exp_lvl = [0, 2, 5, 9, 14, 20, 27, 35, 44, 54, 65, 77, 90, 104, 129, 145, 162, 180, 200]

    @stat_points = 5
    @skill_points = hero[:skill_points]

    @weapon = Weapon.new(hero[:weapon])
  end

  def rest # отдых между боями(Восстановления жизней и маны)
    if @hp_pl < @hp_max_pl
      @hp_pl += [@recovery_hp_pl, @hp_max_pl - @hp_pl].min
      puts "Передохнув вы восстанавливаете #{@recovery_hp_pl.round} жизней, теперь у вас #{@hp_pl.round}/#{@hp_max_pl} жизней"
    end
    if @mp_pl < @mp_max_pl
      @mp_pl += [@recovery_mp_pl, @mp_max_pl - @mp_pl].min
      puts "Передохнув вы восстанавливаете #{@recovery_mp_pl.round} выносливости, теперь у вас #{@mp_pl.round}/#{@mp_max_pl} выносливости"
    end
  end
end


# ["drunk", "watchman", "thief", "worker", "student"].each do |background|
#   p Hero.new(background)
# end
















#
