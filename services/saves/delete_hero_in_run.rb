class DeleteHeroInRun
  PATH = 'saves/'
  HERO_FILE = 'hero_in_run.yml'

  def initialize(hero)
    @hero = hero
  end

  def add_camp_loot_and_delete_hero_file
    if @hero.name != 'Cheater'
      add_camp_loot()
      StatisticsTotal.new.add_from_run(@hero.statistics.data)
    end
    @hero.statistics.delete
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
end
