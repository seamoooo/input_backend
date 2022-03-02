class Progress < ApplicationRecord
  belongs_to :game
  belongs_to :question

  def assign_squence
    next_sequence = 1
    if game.present?
      all_progress = game.progress
      if all_progress.count > 0
        # maximum　カラムの最大値を計算
        next_sequence = all_progress.maximum(:sequence) + 1
      end
    end
    self.sequence = next_sequence
  end

end
