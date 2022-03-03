class Question < ApplicationRecord
  has_many :progress

  def self.next_question(game)
    anssere_question_ids = game.progress.pluck(:question_id)
    Question.where.not(id: anssere_question_ids).shuffle.take(1).first
  end
end
