class Temperature
  attr_reader :file, :file_content, :content_hash

  def initialize
    @file = './w_data.dat'
    @file_content = read_file(file)
    @content_hash = file_content_to_hash(file_content)

    smallest_spread = content_hash.first

    message = "The day with the minimum temperature spread was the #{smallest_spread[:day]}, "\
      "with a maximum temperature of #{smallest_spread[:max_temp]} degrees, a minimum temperature of #{smallest_spread[:min_temp]} degrees "\
      "and a spread of #{smallest_spread[:spread]} degrees."

    p message
  end

  private

  def read_file(f)
    input = File.open(f, File::RDONLY) { |l| l.read }

    input.lines.map(&:split)
  end

  def file_content_to_hash(content)
    result = []

    content.each do |line|
      # the max number of items per line is 17, but most of the lines are missing items
      # however, all "usable" lines have more than 10 items
      next if line.length < 10

      hash = {
        day: line[0],
        max_temp: line[1]&.to_f,
        min_temp: line[2]&.to_f,
        spread: line[1]&.to_f - line[2]&.to_f
      }

      result.push(hash) unless hash[:day] == 'Dy' # remove header line
    end

    result.sort_by { |d| d[:spread] }
  end
end

Temperature.new
