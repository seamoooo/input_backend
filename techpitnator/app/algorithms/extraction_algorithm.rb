class ExtractionAlgorithm
  attr_reader :game
  attr_reader :query

  def initialize(game)
    Rails.logger.debug('ExtractionAlgorithm initialized.')
    @game = game
    @query = Comic.all
  end
  
  def compute
    binding.pry
    progresses = @game.progress
    progresses.each do |progress|
      # question
      question = progress.question

      Rails.logger.debug('On the way query is ' + @query.to_sql.to_s)
      Rails.logger.debug('On the way comics are ' + @query.pluck(:title).to_a.to_s)
    end
    @query
  end
end
