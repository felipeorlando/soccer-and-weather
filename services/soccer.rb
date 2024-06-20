class Soccer
  HEADER_INDEX = {
    position: 0,      # position
    team: 1,          # team
    goals_for: 6,     # F
    separator: 7,     # -
    goals_against: 8  # A
  }

  def get_smallest_hits_and_goals_difference
    top_team = nil
    min_difference = 0

    document.each do |line|
      next if not_data_line?(line)

      data = line.split(' ').map(&:strip)

      team = data[HEADER_INDEX[:team]]
      goals_for = data[HEADER_INDEX[:goals_for]].to_i
      goals_against = data[HEADER_INDEX[:goals_against]].to_i

      difference = (goals_for - goals_against)

      if difference < min_difference
        min_difference = difference.abs
        top_team = team
      end
    end

    puts "Team with the smallest difference between goals for and goals against: #{top_team}, with a difference of #{min_difference}"
  end

  private

  attr_accessor :document

  def document
    @document ||= File.readlines('data/soccer.dat')
  end

  def not_data_line?(line)
    line.strip.empty? || markup_line?(line) || header_line?(line)
  end

  def markup_line?(line)
    ['<pre>', '</pre>', '----'].any? { |word| line.include?(word) }
  end

  def header_line?(line)
    line.include?('Team') && line.include?('Pts')
  end
end
