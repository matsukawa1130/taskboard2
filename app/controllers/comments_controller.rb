class CommentsController < ApplicationController
    def new
      @task = Task.find(params[:task_id])
      @comment = @task.comments.build
      @board = Board.find(params[:board_id])
    end

    def create
        @board = Board.find(params[:task_id])
        @task = Task.find(params[:board_id])
        @comment = @task.comments.build(comment_params.merge!(user_id: current_user.id))
        if @comment.save
          redirect_to board_task_path(@board,@task),notice: '投稿は保存されました'
        else
          flash.now[:error] = '投稿の保存に失敗しました'
          render :new
        end
    end

    private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end