class Soccer
  attr_reader :file, :file_content, :content_hash
  
  def initialize
    @file = './soccer.dat'
    @file_content = read_file(file)
    @content_hash = file_content_to_hash(file_content)

    smallest_difference = content_hash.first
    
    message = "The team with the smallest goal difference is #{smallest_difference[:name]}, "\
      "with #{smallest_difference[:F]} goals in favor and #{smallest_difference[:A]} against, "\
      "for a difference of #{smallest_difference[:Diff]} goals."

    p message
  end

  private

  # read the file
  def read_file(f)
    input = File.open(f, File::RDONLY) { |l| l.read }

    input.lines.map(&:split)
  end

  def file_content_to_hash(content)
    result = []

    # parse the content to create an array of hash with the 'For', 'Against' & 'Difference' for each country
    content.each do |line|
      next if line.count < 10

      hash = { name: line[1], F: line[6].to_i, A: line[8].to_i, Diff: line[6].to_i - line[8].to_i }
      
      result.push(hash)
    end

    # sort the resulting array of hashes in ascending order by Diff
    result.sort_by { |c| c[:Diff] }
  end
end

Soccer.new
