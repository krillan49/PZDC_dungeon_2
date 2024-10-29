module GameEndConcern

  # In your class you need variabels:
  # @messages   for example with MainMessage.new
  # @hero       with charater object

  # !!! You need exit all your event methods after use end_game_and_hero_died or end_game_and_hero_alive method

  def hero_died?
    @hero.hp <= 0
  end

  def end_game_and_hero_died()
    DeleteHeroInRun.new(@hero, :game_over, @messages).add_camp_loot_and_delete_hero_file
  end

  def end_game_and_hero_alive()
    DeleteHeroInRun.new(@hero, :exit, @messages).add_camp_loot_and_delete_hero_file
  end

end
