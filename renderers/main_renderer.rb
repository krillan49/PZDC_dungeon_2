class MainRenderer
  def initialize(menu_name, *characters, **options)
    @menu_name = menu_name
    hh = YAML.safe_load_file("views/menues/#{menu_name}.yml", symbolize_names: true)
    @view = hh[:view]
    @partials = hh[:partials]
    @insert_options = hh[:insert_options]
    @characters = characters
    @entity = options[:entity]
  end

  def display
    if @partials
      @partials.map do |name, options|
        partial = Menu.new(name, @characters[options[:i]]).render.view
        insert_partial_to_view(partial, options)
      end
      @view = Menu.new(@menu_name, @entity, view: @view).render.view
    else
      @view = Menu.new(@menu_name, @characters[0]).render.view
    end
    puts @view
  end

  private

  def insert_partial_to_view(partial, options)
    y_min, y_max = options[:y]
    x_min, x_max = options[:x]
    (y_min..y_max).each.with_index do |y, i|
      (x_min..x_max).each.with_index do |x, j|
        @view[y][x] = partial[i][j]
      end
    end
  end

end

# require 'yaml'
# require_relative "../renderers/menues/menues"
# require_relative "../models/skills/concentration"
# require_relative "../models/skills/dazed"
# require_relative "../models/skills/first_aid"
# require_relative "../models/skills/precise_strike"
# require_relative "../models/skills/shield_master"
# require_relative "../models/skills/strong_strike"
# require_relative "../models/skills/treasure_hunter"
# require_relative "../models/characters/enemy"
# require_relative "../models/characters/hero"
# require_relative "../models/ammunition/arms_armor"
# require_relative "../models/ammunition/body_armor"
# require_relative "../models/ammunition/head_armor"
# require_relative "../models/ammunition/shield"
# require_relative "../models/ammunition/weapon"
#
# hero = Hero.new('Vasya','watchman')
# hero.passive_skill = ShieldMaster.new
# MainRenderer.new(:battle_screen, hero, Enemy.new("Рыцарь-зомби")).display
# MainRenderer.new(:character_stats, hero, Enemy.new("Рыцарь-зомби")).display











#
