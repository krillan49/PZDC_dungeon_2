require 'yaml'

module Art
  def Art.display_art(name)
    art = YAML.safe_load_file('data/arts/arts.yml', symbolize_names: true)[name]
    puts art
  end
end
