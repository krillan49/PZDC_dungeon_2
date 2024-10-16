module DisplayScreenConcern

  # In your class you need variabels:
  # @messages   for example with MainMessage.new

  def display_message_screen(art=:normal)
    MainRenderer.new(:messages_screen, entity: @messages, arts: [{ art => @path_art }]).display
  end

end
