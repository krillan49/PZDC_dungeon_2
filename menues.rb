require 'yaml'

# Вы заметили с одной стороны развилки фигуру рыцаря, идем туда(Y) или свернем в другую сторону? y
# Это рыцарь-зомби, приготовься к сложному бою
# █▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
# █ Your opponent is           Рыцарь-зомби                                                                              █
# █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█
# E:/doc/projects/for_fun/pizd_podz2/menues.rb:39:in `*': negative argument (ArgumentError)
#         from E:/doc/projects/for_fun/pizd_podz2/menues.rb:39:in `length_updater'
#         from E:/doc/projects/for_fun/pizd_podz2/menues.rb:16:in `block (2 levels) in display'
#         from E:/doc/projects/for_fun/pizd_podz2/menues.rb:13:in `each'
#         from E:/doc/projects/for_fun/pizd_podz2/menues.rb:13:in `block in display'
#         from E:/doc/projects/for_fun/pizd_podz2/menues.rb:12:in `each'
#         from E:/doc/projects/for_fun/pizd_podz2/menues.rb:12:in `display'
#         from main.rb:46:in `<main>'

class Menu
  def initialize(menu, character)
    hh = YAML.safe_load_file("graphics/menues/#{menu}.yml", symbolize_names: true)
    @view = hh[:view]
    @insert_options = hh[:insert_options]
    @character = character
  end

  def display
    @insert_options.each do |i, fields|
      fields.each do |field_char, options|
        field_length = @view[i].scan(/#{field_char}{3,}/)[0].size
        data = character_with_methods(options[:methods])
        data_to_insert = length_updater(field_length, data, options[:modifier])
        @view[i].sub!(/#{field_char}{3,}/, data_to_insert)
      end
    end
    puts @view
  end

  private

  def character_with_methods(methods)
    res = @character
    methods.each { |method| res = res.send(method) }
    res.to_s
  end

  def length_updater(field_length, data, modifier)
    return data[0...field_length] if field_length < data.size
    if modifier == 'm'
      half_min = (field_length - data.size) / 2
      half_max = field_length - data.size - half_min
      ' ' * half_max + data + ' ' * half_min
    elsif modifier == 's'
      data + ' ' * (field_length - data.size)
    elsif modifier == 'e'
      ' ' * (field_length - data.size) + data
    end
  end

end

# require_relative 'hero'
# require_relative "skills"
# hero = Hero.new('Vasya','watchman')
# hero.passive_skill = ShieldMaster.new
# Menu.new(:character_stats, hero).display

# require_relative "enemyes"
# Menu.new(:character_stats, Enemy.new("Рыцарь-зомби")).display












#
