class Weather
  def get_min_spread
    day_with_min_spread = nil
    min_spread = 0

    document.each do |line|
      next if not_data_line?(line)

      day, max_temp, min_temp = line.split(' ').map(&:strip)

      spread = (max_temp.to_i - min_temp.to_i)

      if spread < min_spread || min_spread.zero?
        min_spread = spread
        day_with_min_spread = day
      end
    end

    puts "Day with the smallest temperature spread: #{day_with_min_spread}, with a spread of #{min_spread} degrees"
  end

  private

  attr_accessor :document

  def document
    @document ||= File.readlines('data/w_data.dat')
  end

  def not_data_line?(line)
    ['<pre>', '</pre>', 'MMU', 'HDDay'].any? { |word| line.include?(word) } || line.strip.empty?
  end
end
