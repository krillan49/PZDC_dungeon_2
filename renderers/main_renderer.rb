class MainRenderer
  def initialize(menu_name, *characters, **options)
    @menu_name = menu_name
    hh = YAML.safe_load_file("views/menues/#{menu_name}.yml", symbolize_names: true)
    @view = hh[:view]
    @partials = hh[:partials]
    @insert_options = hh[:insert_options] # опции для полей основного меню
    @characters = characters
    @entity = options[:entity]

    @arts = options[:arts]
    @view_arts_options = hh[:arts]
  end

  def display
    if @partials || @arts || @entity
      partials() if @partials # отрисовываем паршалы в @view
      arts() if @arts # отрисовываем картинки в @view
      @view = Menu.new(@menu_name, @entity, view: @view).render.view # заполняем поля материнского экрана
    else
      @view = Menu.new(@menu_name, @characters[0]).render.view
    end
    puts @view
  end

  private

  def partials
    @partials.each.with_index do |partial, i|
      partial_menu = Menu.new(partial[:partial_name], @characters[i]).render.view
      insert_partial_to_view(partial_menu, y: partial[:y], x: partial[:x])
    end
  end

  def arts
    @arts.each.with_index do |art_params, i|
      art_params.each do |art_type, entity|
        art_name = entity.respond_to?(:code_name) ? entity.code_name : entity # для картинок от имени объекта и просто имен картинок
        art = Art.new(art_type, art_name).view
        y_min, y_max, x_min, x_max = align_art_to_view_field(art, i)
        insert_partial_to_view(art, y: [y_min, y_max], x: [x_min, x_max])
      end
    end
  end

  def align_art_to_view_field(art, i)
    field_y_min, field_y_max = @view_arts_options[i][:y]
    field_x_min, field_x_max = @view_arts_options[i][:x]
    field_y_center = (field_y_min + field_y_max) / 2
    field_x_center = (field_x_min + field_x_max) / 2
    art_height = art.length
    art_width = art[0].length
    y_half_1 = art_height / 2 - (art_height.odd? ? 0 : 1)
    y_half_2 = art_height / 2
    y_min = field_y_center - y_half_1
    y_max = field_y_center + y_half_2
    x_half_1 = art_width / 2 - (art_width.odd? ? 0 : 1)
    x_half_2 = art_width / 2
    x_min = field_x_center - x_half_1
    x_max = field_x_center + x_half_2
    [y_min, y_max, x_min, x_max]
  end

  def insert_partial_to_view(partial, options)
    y_min, y_max = options[:y]
    x_min, x_max = options[:x]
    (y_min..y_max).each.with_index do |y, i|
      (x_min..x_max).each.with_index do |x, j|
        @view[y][x] = partial[i][j]
      end
    end
  end

end














#
