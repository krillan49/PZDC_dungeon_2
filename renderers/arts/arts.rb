class Art
  attr_reader :view

  def initialize(art_name, entity)
    url = if entity.respond_to?(:entity_type)
      "#{entity.entity_type}/#{entity.dungeon_name}/_#{entity.code_name}" # enemy
    else
      "_#{entity}"
    end
    @view = YAML.safe_load_file("views/arts/#{url}.yml", symbolize_names: true)[art_name]
  end
end
