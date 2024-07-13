class MainRenderer
  def initialize(menu_name, *characters, **options)
    @menu_name = menu_name
    hh = YAML.safe_load_file("views/menues/#{menu_name}.yml", symbolize_names: true)
    @view = hh[:view]
    @partials = hh[:partials]
    @insert_options = hh[:insert_options] # опции для полей основного меню
    @characters = characters
    @entity = options[:entity]

    @arts = options[:arts]
    @view_arts_options = hh[:arts]
  end

  def display
    if @partials || @arts
      partials() if @partials # отрисовываем паршалы в @view
      arts() if @arts # отрисовываем картинки в @view
      @view = Menu.new(@menu_name, @entity, view: @view).render.view # заполняем поля материнского экрана
    else
      @view = Menu.new(@menu_name, @characters[0]).render.view
    end
    puts @view
  end

  private

  def partials
    @partials.each do |name, options|
      partial = Menu.new(name, @characters[options[:i]]).render.view
      insert_partial_to_view(partial, options)
    end
  end

  def arts
    @arts.each do |art_type, entity|
      art_name = entity.respond_to?(:code_name) ? entity.code_name : entity # для картинок от имени объекта и просто имен картинок
      art = Art.new(art_type, art_name).view
      y_min, y_max, x_min, x_max = align_art_to_view_field(art)
      insert_partial_to_view(art, y: [y_min, y_max], x: [x_min, x_max])
    end
  end

  def align_art_to_view_field(art)
    field_y_min, field_y_max = @view_arts_options[:y]
    field_x_min, field_x_max = @view_arts_options[:x]
    field_y_center = (field_y_min + field_y_max) / 2
    field_x_center = (field_x_min + field_x_max) / 2
    art_height = art.length
    art_width = art[0].length
    y_min = field_y_center - (art_height / 2)
    y_max = field_y_center + (art_height / 2) - 1
    x_min = field_x_center - (art_width / 2)
    x_max = field_x_center + (art_width / 2) - 1
    [y_min, y_max, x_min, x_max]
  end

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
# require_relative "../models/messages/attacks_round_messages"
# require_relative "../renderers/arts/arts"
# hero = Hero.new('Vasya','watchman')
# hero.passive_skill = ShieldMaster.new
# enemy = Enemy.new("Рыцарь-зомби")

# MainRenderer.new(:battle_screen, hero, Enemy.new("Рыцарь-зомби")).display
# MainRenderer.new(:character_stats, hero, Enemy.new("Рыцарь-зомби")).display

# Пример с 2мя паршалами персонажей, сообщениями меню и картинкой
# MainRenderer.new(
#   :battle_screen,
#   hero, enemy,
#   entity: AttacksRoundMessages.new,
#   arts: { attack: enemy }
# ).display











#
