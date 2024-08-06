class DeleteHeroInRun
  PATH = 'saves/'
  HERO_FILE = 'hero_in_run.yml'

  def initialize(hero)
    @hero = hero
  end

  def add_camp_loot_and_delete_hero_file
    add_camp_loot()
    delete_hero_file()
  end

  def add_camp_loot
    # сохранение/передача очков монолита от героя в монолит
    PzdcMonolith.new.add_points(@hero.pzdc_monolith_points)
    @hero.pzdc_monolith_points = 0
  end

  def delete_hero_file
    File.delete("#{PATH}#{HERO_FILE}") if File::exists?("#{PATH}#{HERO_FILE}")
  end
end
