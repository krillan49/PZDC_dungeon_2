module AmmunitionShow

  def self.show_weapon_buttons_actions(distribution, character)
    if %w[A B C D E].include?(distribution)
      ammunition_type = {A: 'weapon', B: 'head_armor', C: 'body_armor', D: 'arms_armor', E: 'shield'}[distribution.to_sym]
      ammunition_obj = character.send(ammunition_type)
      if ammunition_obj.code != 'without'
        AmmunitionShow.display(obj: ammunition_obj, type: ammunition_type, arts: [{normal: ammunition_obj}])
      end
    end
  end

  def self.display(params)
    ammunition_type = params[:type]
    if params[:obj]
      ammunition_obj = params[:obj]
    else
      ammunition_code = params[:code]
      ammunition_obj = AmmunitionCreator.create(ammunition_type, ammunition_code)
    end
    MainRenderer.new(:"ammunition_#{ammunition_type}_screen", entity: ammunition_obj, arts: params[:arts]).display
    gets
  end

end
