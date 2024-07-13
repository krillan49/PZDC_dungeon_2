class Art
  # Устарело, потом переделать
  def Art.display_art(name)
    art = YAML.safe_load_file('views/arts/arts.yml', symbolize_names: true)[name]
    puts art
  end

  attr_reader :view

  def initialize(art_name, entity)
    hh = YAML.safe_load_file("views/arts/_#{entity.code_name}.yml", symbolize_names: true)
    @view = hh[art_name]
  end
end
