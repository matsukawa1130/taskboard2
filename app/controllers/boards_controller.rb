class BoardsController < ApplicationController
    def index
        @boards = Board.all
    end

    def show
        @board = Board.find(params[:id])
    end

    def new
        @board = Board.new
    end

    def create
        @board = Board.new(board_params)
        if @board.save
          redirect_to board_path(@board),notice: '投稿は保存されました'
        else
          flash.now[:error] = '投稿の保存に失敗しました'
          render :new
        end
    end

    private
    def board_params
        params.require(:board).permit(:title, :content)
    end
end