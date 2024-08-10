class Art
  attr_reader :view

  def initialize(type, name)
    hh = YAML.safe_load_file("views/arts/_#{name}.yml", symbolize_names: true)
    @view = hh[type]
  end
end


class ArtNew
  attr_reader :view

  def initialize(type, entity)
    url = entity.respond_to?(:art_url) ? entity.art_url : entity
    @view = YAML.safe_load_file("views/arts/#{url}.yml", symbolize_names: true)[type]
  end
end
