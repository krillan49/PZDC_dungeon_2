module AmmunitionShow
  def self.show(ammunition_type, ammunition_code)
    ammunition_obj = AmmunitionCreator.create(ammunition_type, ammunition_code)
    MainRenderer.new(:"ammunition_#{ammunition_type}_screen", entity: ammunition_obj).display
    gets
  end
end
