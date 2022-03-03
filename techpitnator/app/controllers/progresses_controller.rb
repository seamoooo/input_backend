class ProgressesController < ApplicationController

  def new
    @progress = Progress.new
    current_game = Game.find(params[:game_id])
    @question = Question.next_question(current_game)
  end

  def create
    current_game = Game.find(params[:game_id])

    # Progress.newにしないことで、game_idがバインドされて生成さる
    progress = current_game.progress.new(create_params)
    progress.assign_squence

    progress.save!

    redirect_to new_game_progresses_path(current_game)
  end

  private
  # ユーザーから入力された値をパラメーターとしてDBに保存する場合はストロングパラメータが必要
  def create_params
    params.require(:progress).permit(:question_id, :answer)
  end
end
