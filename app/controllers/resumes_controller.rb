class ResumesController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :show, :update, :destroy]

  def index
    @job = Job.find(params[:job_id])
    @resumes = @jobs.resumes
  end

  def new
    @job = Job.find(params[:job_id])
    @resume = Resume.new
  end


  def create
    @job = Job.find(params[:job_id])
    @resume = Resume.new(resume_params)
    @resume.job = @job
    @resume.user = current_user
    if @resume.save
      redirect_to root_path, notice: "你已成功上传简历"
    else
      render :new
    end
  end

  def destroy
    @job = Job.find(params[:job_id])
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to job_path(@job), alert: "你已经成功删除简历"
  end



  private

  def resume_params
    params.require(:resume).permit(:content, :attachment)
  end
end
