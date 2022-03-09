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

    @extact_commics = ExtractionAlgorithm.new(current_game).compute

   # 絞り込み結果が0件の場合、ギブアップ画面へ遷移
   if @extact_commics.count == 0
    redirect_to give_up_game_path(current_game)
    return
   end

    # 絞り込み結果が1件の場合、チャレンジへ遷移
    if @extact_commics.count == 1
      redirect_to challenge_game_path(current_game)
      return
    end

    next_question = Question.next_question(current_game)
    if next_question.blank?

      current_game.status = 'finished'
      current_game.result = 'incorrect'
      current_game.save!

      redirect_to give_up_game_path(current_game)
      # redirect先が二つあるので、retrunで処理を終了させる必要がある。
      return
    end
  
    redirect_to new_game_progresses_path(current_game)
  end

  private
  # ユーザーから入力された値をパラメーターとしてDBに保存する場合はストロングパラメータが必要
  def create_params
    params.require(:progress).permit(:question_id, :answer)
  end
end
