class NewMain
  def initialize
    @hero = nil
    @leveling = 0

    @messages = MainMessage.new
  end

  def start_game
    # Создание начальных yml
    PzdcMonolith.new
    # ход игры
    loop do
      change_screen()
      MainRenderer.new( :start_game_screen, arts: [ { poster_start: :poster_start } ] ).display
      choose = gets.to_i
      if choose == 2
        # Лагерь
        CampEngine.new.camp
      else
        # Забег
        load_or_create_hero()
        Run.new(@hero, @leveling).start if @hero
      end
    end
  end

  def load_or_create_hero
    change_screen()
    MainRenderer.new(:load_new_run_screen).display
    new_load = gets.strip
    change_screen()
    if new_load == '2'
      @hero = HeroCreator.new.create_new_hero # Создание нового персонажа
    else
      load_hero = LoadHeroInRun.new
      load_hero.load
      @hero = load_hero.hero
      @leveling = load_hero.leveling
    end
  end

  private

  def display_message_screen_with_confirm_and_change_screen
    @messages.main = 'To continue press Enter'
    MainRenderer.new(:messages_screen, entity: @messages).display
    @messages.clear_log
    confirm_and_change_screen()
  end

  def confirm_and_change_screen
    gets
    change_screen()
  end

  def change_screen
    puts "\e[H\e[2J"
  end
end

















#
