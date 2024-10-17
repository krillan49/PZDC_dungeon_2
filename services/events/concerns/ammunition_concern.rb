module AmmunitionConcern

  # In your class you need variabels:
  # @messages   for example with MainMessage.new
  # @hero       with charater object

  def ammunition_loot(params)
    @messages.main = params[:message] ? params[:message] : "Change #{ammunition_code.split('_').join(' ')}?"
    if params[:ammunition_obj]
      ammunition_obj = params[:ammunition_obj]
      ammunition_type = ammunition_obj.ammunition_type
      ammunition_code = ammunition_obj.code
    else
      ammunition_type = params[:ammunition_type]
      ammunition_code = params[:ammunition_code]
      ammunition_obj = AmmunitionCreator.create(ammunition_type, ammunition_code)
    end
    display_loot_screen(ammunition_type.to_sym, @hero.send(ammunition_type), ammunition_obj)
    choose = gets.strip.upcase
    @hero.send("#{ammunition_type}=", ammunition_obj) if choose == 'Y'
    choose == 'Y' ? true : false
  end

  def display_loot_screen(ammunition_type, hero_ammunition_obj, enemy_ammunition_obj)
    MainRenderer.new(
      :"loot_enemy_#{ammunition_type}",
      hero_ammunition_obj,
      enemy_ammunition_obj,
      entity: @messages,
      arts: [{normal: hero_ammunition_obj}, {normal: enemy_ammunition_obj}]
    ).display
  end

end
