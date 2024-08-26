class Main
  def initialize
    @hero = nil
    @leveling = 0

    @messages = MainMessage.new
  end

  def start_game
    # Создание начальных yml
    PzdcMonolith.new
    Shop.new
    # ход игры
    loop do
      MainRenderer.new(:start_game_screen).display
      choose = gets.strip
      if choose == '0'
        puts "\e[H\e[2J"
        exit
      elsif choose == '2'
        # Лагерь
        CampEngine.new.camp
      else
        # Забег
        load_or_start_new_run()
        Run.new(@hero, @leveling).start if @hero
      end
    end
  end

  def load_or_start_new_run
    MainRenderer.new(:load_new_run_screen, arts: [ { dungeon_cave: :dungeon_enter } ] ).display
    new_load = gets.strip
    if new_load == '1'
      load_run()
    elsif new_load == '2'
      start_new_run()
    end
  end

  def load_run
    load_hero = LoadHeroInRun.new
    load_hero.load
    @hero = load_hero.hero
    @leveling = load_hero.leveling if @hero # условие чтобы не возвращало nil и не было ошибки
  end

  def start_new_run
    new_dungeon_num = 0
    until [1, 2, 3].include?(new_dungeon_num)
      MainRenderer.new(:choose_dungeon_screen).display
      new_dungeon_num = gets.to_i
    end
    dungeon_name = %w[bandits undeads greenskins][new_dungeon_num-1]
    # Создание нового персонажа
    @hero = HeroCreator.new(dungeon_name).create_new_hero
  end

end

















#
