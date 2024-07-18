class Menu
  attr_reader :view

  def initialize(menu_name, entity, **params)
    hh = YAML.safe_load_file("views/menues/#{menu_name}.yml", symbolize_names: true)
    @view = params[:view] ? params[:view] : hh[:view] # для составного или простого меню
    @insert_options = hh[:insert_options]
    @entity = entity
  end

  def render
    return self if !@insert_options
    @insert_options.each do |i, fields|
      fields.each do |field_char, options|
        field_length = @view[i].scan(/#{field_char}{3,}/)[0].size
        data = entity_with_methods(options[:methods])
        data_to_insert = length_updater(field_length, data, options[:modifier])
        @view[i].sub!(/#{field_char}{3,}/, data_to_insert)
      end
    end
    self
  end

  private

  def entity_with_methods(methods)
    res = @entity
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
