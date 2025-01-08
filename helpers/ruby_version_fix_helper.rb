module RubyVersionFixHelper
  def self.file_exists?(path)
    begin
      File::exists?(path)
    rescue NoMethodError => e
      if e.message.include?("exists?")
        File.exist?(path)
      else
        raise
      end
    end
  end
end
