class CampFireEngine
  def initialize(hero)
    @hero = hero
    @messages = MainMessage.new
  end

  def start
    HeroActions.rest(@hero, @messages)
    choose = nil
    until ['0', ''].include?(choose)
      MainRenderer.new(:rest_menu_screen, entity: @messages, arts: [{ camp_fire_big: :rest }]).display
      choose = gets.strip.upcase
      if choose == '1'
        OccultLibraryEnhanceController.new(@hero).recipes_list
      elsif choose == '2'
        HeroUseSkill.camp_skill(@hero, @messages)
        @messages.log.shift if @messages.log.length > 3
      end
    end
  end

end
