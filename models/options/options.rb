class Options
  PATH = 'saves/options.yml'
  SPEEDS_FOR_ANIMATIONS = [0.1, 0.4, 0.7, 1, 1.5]
  SCREEN_REPLACEMENT_TYPES = ["\x1bc", "\e[H\e[2J", "\e[2J"]

  def initialize
    create()
    @options = YAML.safe_load_file(PATH)
  end

  # getters for actions:
  def get_enemy_actions_animation_speed
    @options['enemy_actions_animation_speed']
  end

  def get_screen_replacement_type
    @options['screen_replacement_type']
  end

  # setters:
  def set_enemy_actions_animation_speed_to(i)
    @options['enemy_actions_animation_speed'] = SPEEDS_FOR_ANIMATIONS[i]
    update()
  end

  def set_screen_replacement_type_to(i)
    @options['screen_replacement_type'] = SCREEN_REPLACEMENT_TYPES[i]
    update()
  end

  # getters for views:
  def method_missing(method)
    method_name, par = method.to_s.split('__')
    if method_name == 'enemy_actions_animation_speed'
      @options['enemy_actions_animation_speed'] == SPEEDS_FOR_ANIMATIONS[par.to_i] ? '   (+)   ' : "[Enter #{par.to_i+1}]"
    elsif method_name == 'screen_replacement_type'
      @options['screen_replacement_type'] == SCREEN_REPLACEMENT_TYPES[par.to_i] ? '   (+)   ' : "[Enter #{par.to_i+1}]"
    end
  end

  private

  def create
    File.write(PATH, new_file_data().to_yaml) unless RubyVersionFixHelper.file_exists?(PATH)
  end

  def update
    File.write(PATH, @options.to_yaml)
  end

  def new_file_data
    {
      'enemy_actions_animation_speed' => 0.7,
      'screen_replacement_type' => '\x1bc'
    }
  end
end
