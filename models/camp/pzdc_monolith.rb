class PzdcMonolith
  PATH = 'saves/pzdc_monolith.yml'

  def initialize
    File.write("#{PATH}", { 'points' => 0 }.to_yaml) unless File::exists?("#{PATH}")
    @monolith = YAML.safe_load_file('saves/pzdc_monolith.yml')
  end

  def add_points(n)
    @monolith['points'] += n
    File.write("#{PATH}", @monolith.to_yaml)
  end

  def take_point(n)
    @monolith['points'] -= n
    File.write("#{PATH}", @monolith.to_yaml)
  end
end
