class TasksController < ApplicationController
    def index
        @boards = Board.all
        @board = Board.find(params[:board_id])
        @tasks = @board.tasks
    end
    
    def new
      board = Board.find(params[:board_id])
      @task = board.tasks.build
    end

    def show
      @task = Task.find(params[:id])
      @boards = Board.all
      @board = Board.find(params[:board_id])
      @tasks = @board.tasks
    end

    def create
      board = Board.find(params[:board_id])
      @task = board.tasks.build(task_params.merge!(user_id: current_user.id))
      if @task.save
        redirect_to board_tasks_path(board.id), notice: 'タスクを追加'
      else
        flash.now[:error] = '更新できませんでした'
        render :new
      end
    end

    def edit
      @task = current_user.tasks.find(params[:id])
    end

   def update
       @task = current_user.tasks.find(params[:id])
     if @task.update(task_params)
       redirect_to board_tasks_path(@task.board),notice: '投稿は更新されました'
     else
       flash.now[:error] = '更新できませんでした'
       render :edit
     end
   end

   def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    board = Board.find(params[:board_id])
    redirect_to board_tasks_path(board), notice: '削除に成功しました'
   end

    private
    def task_params
      params.require(:task).permit(:title, :content, :deadline, :eyecatch, :description)
    end
end