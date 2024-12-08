class DeleteHeroInRun
  PATH = 'saves/'
  HERO_FILE = 'hero_in_run.yml'

  def initialize(hero, game_status, messages=nil)
    @hero = hero
    @game_status = game_status
    @messages = messages
  end

  def add_camp_loot_and_delete_hero_file
    if @game_status == :game_completed
      display_game_completed()
    elsif %i[game_over dungeon_completed game_completed].include?(@game_status)
      display_with_status()
    else
      display_statistics()
    end
    if @hero.name != 'Cheater'
      add_camp_loot()
      StatisticsTotal.new.add_from_run(@hero.statistics.data)
    end
    @hero.statistics.delete
    @hero = nil
    delete_hero_file()
  end

  def add_camp_loot
    # saving/transferring monolith points from hero to monolith
    PzdcMonolith.new.add_points(@hero.pzdc_monolith_points)
    @hero.pzdc_monolith_points = 0
    # adding items and coins to the shop
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

  def display_game_completed
    MainRenderer.new(:messages_low_screen, entity: @messages, arts: [{ @game_status => :game_over }]).display
    gets
    display_statistics()
    MainRenderer.new(:credits_screen).display
    gets
  end

  def display_with_status
    MainRenderer.new(:messages_screen, entity: @messages, arts: [{ @game_status => :game_over }]).display
    gets
    display_statistics()
  end

  def display_statistics
    MainRenderer.new(:statistics_enemyes_screen, entity: @hero.statistics).display
    gets
  end
end
