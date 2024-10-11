require 'yaml'
require_relative "../helpers/ruby_version_fix_helper"

# engines -----------------------------
require_relative "../engines/main"
require_relative "../engines/camp_engine"
require_relative "../engines/options_engine"
require_relative "../engines/run"
require_relative "../engines/attacks_round"
require_relative "../engines/loot_round"
require_relative "../engines/occult_library_enhance_engine"

# renderers ---------------------------
require_relative "../renderers/arts/arts"
require_relative "../renderers/menues/menues"

# services ----------------------------
# saves
require_relative "../services/saves/save_hero_in_run"
require_relative "../services/saves/load_hero_in_run"
require_relative "../services/saves/delete_hero_in_run"
# loot
require_relative "../services/loot/pzdc_monolith_loot"
require_relative "../services/loot/enemy_loot"
require_relative "../services/loot/field_loot"
require_relative "../services/loot/secret_loot"
# actions
require_relative "../services/actions/occult_library_enhance_service"

# controllers -------------------------
# ammunition
require_relative "../controllers/ammunition/ammunition_creator"
require_relative "../controllers/ammunition/ammunition_show"
# skills
require_relative "../controllers/skills/skills_creator"
require_relative "../controllers/skills/skills_show"
# characters
require_relative "../controllers/characters/enemy_creator"
require_relative "../controllers/characters/hero_creator"
require_relative "../controllers/characters/hero_updator"
require_relative "../controllers/characters/hero_actions"
require_relative "../controllers/characters/enemy_actions"
require_relative "../controllers/characters/hero_use_skill"

# models ------------------------------
# options
require_relative "../models/options/options"
# camp
require_relative "../models/camp/warehouse"
require_relative "../models/camp/pzdc_monolith"
require_relative "../models/camp/shop"
require_relative "../models/camp/occult_library"
require_relative "../models/camp/occult_library_at_run"
require_relative "../models/camp/occult_library_recipe"
# ammunition
require_relative "../models/ammunition/arms_armor"
require_relative "../models/ammunition/body_armor"
require_relative "../models/ammunition/head_armor"
require_relative "../models/ammunition/shield"
require_relative "../models/ammunition/weapon"
# skills
require_relative "../models/skills/precise_strike"
require_relative "../models/skills/strong_strike"
require_relative "../models/skills/berserk"
require_relative "../models/skills/concentration"
require_relative "../models/skills/dazed"
require_relative "../models/skills/shield_master"
require_relative "../models/skills/bloody_ritual"
require_relative "../models/skills/first_aid"
require_relative "../models/skills/treasure_hunter"
# characters
require_relative "../models/characters/enemy"
require_relative "../models/characters/hero"
# messages
require_relative "../models/messages/attacks_round_message"
require_relative "../models/messages/main_message"
require_relative "../models/messages/load_hero_message"

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
    render_screen()
    show_screen()
  end

  def render_screen
    if @partials || @arts || @entity
      partials() if @partials # отрисовываем паршалы в @view
      arts() if @arts # отрисовываем картинки в @view
      @view = Menu.new(@menu_name, @entity, view: @view).render.view # заполняем поля материнского экрана
    else
      @view = Menu.new(@menu_name, @characters[0]).render.view
    end
  end

  def show_screen
    puts "\e[H\e[2J"
    puts @view
  end

  private

  def partials
    @partials.each.with_index do |partial, i|
      partial_menu = Menu.new(partial[:partial_name], @characters[i]).render.view
      insert_partial_to_view(partial_menu, y: partial[:y], x: partial[:x])
    end
  end

  def arts
    @arts.each.with_index do |art_params, i|
      art_params.each do |art_name, entity|
        art = Art.new(art_name, entity).view
        y_min, y_max, x_min, x_max = align_art_to_view_field(art, i)
        insert_partial_to_view(art, y: [y_min, y_max], x: [x_min, x_max])
      end
    end
  end

  def align_art_to_view_field(art, i)
    field_y_min, field_y_max = @view_arts_options[i][:y]
    field_x_min, field_x_max = @view_arts_options[i][:x]
    field_y_center = (field_y_min + field_y_max) / 2
    field_x_center = (field_x_min + field_x_max) / 2
    art_height = art.length
    art_width = art[0].length
    y_half_1 = art_height / 2 - (art_height.odd? ? 0 : 1)
    y_half_2 = art_height / 2
    y_min = field_y_center - y_half_1
    y_max = field_y_center + y_half_2
    x_half_1 = art_width / 2 - (art_width.odd? ? 0 : 1)
    x_half_2 = art_width / 2
    x_min = field_x_center - x_half_1
    x_max = field_x_center + x_half_2
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

messages = MainMessage.new
messages.main = 'Change ammunition?'

hero = Hero.new('Vasya','watchman')
hero.active_skill = PreciseStrike.new
hero.passive_skill = ShieldMaster.new
hero.camp_skill = TreasureHunter.new
enemy = Enemy.new("e1", 'undeads')
enemy2 = Enemy.new("e2", 'undeads')
enemy3 = Enemy.new("e3", 'undeads')
enemy4 = Enemy.new("e4", 'undeads')
enemy5 = Enemy.new("e5", 'undeads')
enemy6 = Enemy.new("boss", 'undeads')



# ammunition_type = 'body_armor'
# hero_ammunition_obj = BodyArmor.new('rusty_chain_mail')
# enemy_ammunition_obj = BodyArmor.new('chain_mail')
# MainRenderer.new(
#   :"loot_enemy_#{ammunition_type}",
#   hero_ammunition_obj,
#   enemy_ammunition_obj,
#   entity: messages,
#   arts: [{normal: hero_ammunition_obj}, {normal: enemy_ammunition_obj}]
# ).display

# ['e1', 'e2', 'e3', 'e4', 'e5', 'boss'].each do |en|
  obj = Enemy.new('e5', 'swamp')
  MainRenderer.new( :battle_screen, hero, obj, entity: AttacksRoundMessage.new, arts: [{ normal: obj }] ).display
  MainRenderer.new( :battle_screen, hero, obj, entity: AttacksRoundMessage.new, arts: [{ attack: obj }] ).display
  MainRenderer.new( :battle_screen, hero, obj, entity: AttacksRoundMessage.new, arts: [{ damaged: obj }] ).display
  MainRenderer.new( :battle_screen, hero, obj, entity: AttacksRoundMessage.new, arts: [{ dead: obj }] ).display
# end

# MainRenderer.new(
#   :enemy_choose_screen,
#   enemy, enemy3, enemy5,
#   entity: AttacksRoundMessage.new,
#   arts: [{ mini: enemy }, { mini: enemy3 }, { mini: enemy5 }]
# ).display


# MainRenderer.new(:battle_screen, hero, enemy).display
# MainRenderer.new(:character_stats, hero, enemy).display
# Пример с 2мя паршалами персонажей, сообщениями меню и картинкой
# MainRenderer.new( :battle_screen, hero, enemy5, entity: AttacksRoundMessage.new, arts: [{ normal: enemy5 }] ).display
# MainRenderer.new( :battle_screen, hero, enemy5, entity: AttacksRoundMessage.new, arts: [{ attack: enemy5 }] ).display
# MainRenderer.new( :battle_screen, hero, enemy5, entity: AttacksRoundMessage.new, arts: [{ damaged: enemy5 }] ).display
# MainRenderer.new( :battle_screen, hero, enemy5, entity: AttacksRoundMessage.new, arts: [{ dead: enemy5 }] ).display
# MainRenderer.new( :battle_screen, hero, enemy, entity: AttacksRoundMessage.new, arts: [{ game_over: :game_over }] ).display

# MainRenderer.new( # 2 картинки
#   :battle_screen,
#   hero, enemy,
#   entity: AttacksRoundMessage.new, arts: [ { normal: enemy }, { game_over: :game_over } ]
# ).display

# # Без инсерт оптионс
# MainRenderer.new(
#   :start_screen,
#   arts: [ { poster_start: :poster_start } ]
# ).display

# MainRenderer.new(:run_win_screen, entity: MainMessage.new, arts: [{ win_art: :win_art }]).display

# MainRenderer.new( :enemy_start_screen, enemy, entity: AttacksRoundMessage.new, arts: [{ normal: enemy }] ).display

# MainRenderer.new( :hero_update_screen, hero, hero, entity: AttacksRoundMessage.new ).display













#
