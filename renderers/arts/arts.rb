class Art
  ALT = [
    '==================',
    '   NO IMAGE YET   ',
    '=================='
  ]

  attr_reader :view

  def initialize(art_name, entity)
    path = "views/arts/#{sub_path(entity)}.yml"
    @view = file(path, art_name)
  end

  def file(path, art_name)
    if RubyVersionFixHelper.file_exists?(path)
      YAML.safe_load_file(path, symbolize_names: true)[art_name] || ALT
    else
      ALT
    end
  end

  def sub_path(entity)
    if entity.respond_to?(:entity_type)
      if entity.entity_type == 'enemyes'
        "#{entity.entity_type}/#{entity.dungeon_name}/_#{entity.code_name}"
      elsif entity.entity_type == 'ammunition'
        "#{entity.entity_type}/#{entity.ammunition_type}/_#{entity.code}"
      elsif entity.entity_type == 'skills'
        "#{entity.entity_type}/_#{entity.code}"
      elsif entity.entity_type == 'events'
        entity.path_art
      end
    elsif entity.to_s.include?("/")
      "#{entity}"
    else
      "_#{entity}"
    end
  end
end













#
