module RubyVersionFixHelper
  def self.file_exists?(path)
    begin
      File::exists?(path)
    rescue NoMethodError => e
      if e.message.include?("undefined method `exists?' for File:Class")
        File.exist?(path)
      else
        raise NoMethodError, e.message
      end
    end
  end
end
