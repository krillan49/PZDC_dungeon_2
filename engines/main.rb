class Main
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
      MainRenderer.new(:start_game_screen, arts: [ { poster_start: :poster_start } ]).display
      choose = gets.strip
      if choose == '0'
        puts "\e[H\e[2J"
        exit
      elsif choose == '2'
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
    MainRenderer.new(:load_new_run_screen, arts: [ { dungeon_cave: :dungeon_enter } ] ).display
    new_load = gets.strip
    if new_load == '2'
      @hero = HeroCreator.new.create_new_hero # Создание нового персонажа
    else
      load_hero = LoadHeroInRun.new
      load_hero.load
      @hero = load_hero.hero
      @leveling = load_hero.leveling if @hero # условие чтобы не возвращало nil и не было ошибки
    end
  end

  private

  def display_message_screen_with_confirm_and_change_screen
    @messages.main = 'To continue press Enter'
    MainRenderer.new(:messages_screen, entity: @messages).display
    @messages.clear_log
    gets
  end
  
end

















#
