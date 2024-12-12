class Main
  def initialize
    @hero = nil
    @messages = MainMessage.new
  end

  def start_game
    # Creating starrt yml files
    Warehouse.new
    PzdcMonolith.new
    Shop.new
    OccultLibrary.new
    Options.new
    StatisticsTotal.new
    # game start
    loop do
      @messages.main = PzdcDungeon2.v_version
      MainRenderer.new(:start_game_screen, entity: @messages).display
      choose = gets.strip
      if choose == '0'
        exit_game()
      elsif choose == '2'
        camp()
      elsif choose == '3'
        options()
      elsif choose == '4'
        credits()
      else
        load_or_start_new_run()
      end
    end
  end

  def exit_game
    print Options.new.get_screen_replacement_type
    exit
  end

  def camp
    CampEngine.new.camp
  end

  def options
    OptionsEngine.new.main
  end

  def credits
    MainRenderer.new(:credits_screen).display
    gets
  end

  def load_or_start_new_run
    choose = nil
    until choose == 0
      @hero = nil   # to delete hero object with exit from load_run() method
      boss = boss?()
      @messages.main = boss ? '+ PZDC BOSS     [Enter 3] +' : ''
      MainRenderer.new(:load_new_run_screen, entity: @messages, arts: [ { dungeon_cave: :dungeon_enter } ] ).display
      choose = gets.to_i
      if choose == 1
        load_run()
        if @hero
          @hero.statistics = StatisticsRun.new(@hero.dungeon_name)
          @hero.dungeon_name == 'pzdc' ? RunBoss.new(@hero).start : Run.new(@hero).start
        end
      elsif choose == 2
        start_new_run()
        @hero.statistics = StatisticsRun.new(@hero.dungeon_name, true) if @hero
        Run.new(@hero).start if @hero
      elsif choose == 3 && boss
        start_boss_run()
        @hero.statistics = StatisticsRun.new(@hero.dungeon_name, true) if @hero
        RunBoss.new(@hero).start if @hero
      end
    end
  end

  def boss?
    sd = StatisticsTotal.new.data
    sd['bandits']['bandit_leader'] > 0 && sd['undeads']['zombie_knight'] > 0 && sd['swamp']['ancient_snail'] > 0
  end

  def load_run
    load_hero = LoadHeroInRun.new
    load_hero.load
    hero = load_hero.hero
    return if hero == nil
    choose = nil
    until ['Y', 'N', ''].include?(choose)
      @messages.main = 'Load game [Enter Y]            Back to menu [Enter N]'
      @messages.log = ["#{hero.dungeon_name.capitalize}", hero.leveling + 1]
      MainRenderer.new(
        :hero_sl_screen,
        hero, hero,
        entity: @messages,
        arts: [ { normal: :"dungeons/_#{hero.dungeon_name}" }]
      ).display
      choose = gets.strip.upcase
      AmmunitionShow.show_weapon_buttons_actions(choose, hero)
    end
    @hero = hero if choose == 'Y'
  end

  def start_new_run
    new_dungeon_num = 9000
    until [0, 1, 2, 3].include?(new_dungeon_num)
      MainRenderer.new(
        :choose_dungeon_screen,
        arts: [ { normal: :"dungeons/_bandits" }, { normal: :"dungeons/_undeads" }, { normal: :"dungeons/_swamp" } ]
      ).display
      new_dungeon_num = gets.to_i
    end
    if [1, 2, 3].include?(new_dungeon_num)
      dungeon_name = %w[bandits undeads swamp][new_dungeon_num-1]
      # Creating new hero object
      @hero = HeroCreator.new(dungeon_name).create_new_hero
    end
  end

  def start_boss_run
    new_boss_num = 9000
    until [0, 1, 2, 3].include?(new_boss_num)
      MainRenderer.new( :choose_pzdc_boss_screen, arts: [ { big: :"dungeons/_pzdc" } ] ).display
      new_boss_num = gets.to_i
    end
    # Creating new hero object
    @hero = HeroCreator.new('pzdc').create_new_hero if new_boss_num == 1
  end

end

















#
