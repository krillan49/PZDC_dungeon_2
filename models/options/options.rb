class Options
  PATH = 'saves/options.yml'
  SPEEDS_FOR_ANIMATIONS = [0.1, 0.4, 0.7, 1, 1.5]

  def initialize
    create()
    @options = YAML.safe_load_file(PATH)
  end

  def get_enemy_actions_animation_speed
    @options['enemy_actions_animation_speed']
  end

  def set_enemy_actions_animation_speed_to(n)
    @options['enemy_actions_animation_speed'] = SPEEDS_FOR_ANIMATIONS[n-1]
    update()
  end

  # getters for views:
  def method_missing(method)
    method_name, par = method.to_s.split('__')
    if method_name == 'enemy_actions_animation_speed'
      @options['enemy_actions_animation_speed'] == SPEEDS_FOR_ANIMATIONS[par.to_i] ? '   (+)   ' : "[Enter #{par.to_i+1}]"
    end
  end

  private

  def create
    File.write(PATH, new_file_data().to_yaml) unless RubyVersionFixHelper.file_exists?(PATH) # File::exists?(PATH)
  end

  def update
    File.write(PATH, @options.to_yaml)
  end

  def new_file_data
    {
      'enemy_actions_animation_speed' => 1
    }
  end
end
