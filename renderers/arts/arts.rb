class Art
  attr_reader :view

  def initialize(type, name)
    hh = YAML.safe_load_file("views/arts/_#{name}.yml", symbolize_names: true)
    @view = hh[type]
  end
end
