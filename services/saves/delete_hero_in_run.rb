class DeleteHeroInRun
  PATH = 'saves/'
  HERO_FILE = 'hero_in_run.yml'

  def initialize(hero, game_over, messages=nil)
    @hero = hero
    @game_over = game_over
    @messages = messages
  end

  def add_camp_loot_and_delete_hero_file
    @game_over ? display_game_over() : display()
    if @hero.name != 'Cheater'
      add_camp_loot()
      StatisticsTotal.new.add_from_run(@hero.statistics.data)
    end
    @hero.statistics.delete
    @hero = nil
    delete_hero_file()
  end

  def add_camp_loot
    # сохранение/передача очков монолита от героя в монолит
    PzdcMonolith.new.add_points(@hero.pzdc_monolith_points)
    @hero.pzdc_monolith_points = 0
    # добавление вещей и монет в магазин
    if @hero.hp > 0
      shop = Shop.new
      shop.add_ammunition_from(@hero)
      warehouse = Warehouse.new
      warehouse.add_coins_from(@hero)
    end
  end

  def delete_hero_file
    if RubyVersionFixHelper.file_exists?("#{PATH}#{HERO_FILE}") # File::exists?("#{PATH}#{HERO_FILE}")
      File.delete("#{PATH}#{HERO_FILE}")
    end
  end

  private

  def display_game_over
    MainRenderer.new(:messages_screen, entity: @messages, arts: [{ game_over: :game_over }]).display
    gets
    MainRenderer.new(:statistics_enemyes_screen, entity: @hero.statistics).display
    gets
  end

  def display
    MainRenderer.new(:statistics_enemyes_screen, entity: @hero.statistics).display
    gets
  end
end
