class TasksController < ApplicationController
  before_action :set_task, only: [:upload_file, :edit, :update, :change_state, :destroy]

  def index
    @tasks = current_user.tasks.order(:created_at).page(params[:page])
    @task = Task.new
  end

  def create
    @task = current_user.tasks.create(task_params)
    respond_to { |f| f.js }
  end

  def edit
  end

  def update
  end

  def change_state
    @task.switch!
    respond_to { |f| f.js }
  end

  def upload_file
    file = attachment_params[:file]
    is_uploaded_file = file.is_a? ActionDispatch::Http::UploadedFile
    @task.attachments.create(file: file) if is_uploaded_file
    redirect_to root_path
  end

  def destroy
    @task.destroy
    respond_to { |f| f.js }
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, attachments_attributes: [:file])
  end

  def attachment_params
    params.require(:attachment).permit(:file)
  end

  def set_task
    @task = Task.find_by_id(params[:id])
  end
end
