class GamesController < ApplicationController

  def new
  end

  def create
    game = Game.create!(status: 'in_progress')
    # prefixのあるパスに対象のオブジェクトを引数で渡すと、
    # 自動でidを検索してくれて、よしなにパスを生成してくれる
    redirect_to new_game_progresses_path(game)
  end

  def give_up

  end
end
