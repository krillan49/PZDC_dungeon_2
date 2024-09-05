module AmmunitionShow

  def self.display(params)
    ammunition_type = params[:type]
    if params[:obj]
      ammunition_obj = params[:obj]
    else
      ammunition_code = params[:code]
      ammunition_obj = AmmunitionCreator.create(ammunition_type, ammunition_code)
    end
    MainRenderer.new(:"ammunition_#{ammunition_type}_screen", entity: ammunition_obj).display
    gets
  end

end
