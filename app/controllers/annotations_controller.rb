class AnnotationsController < ApplicationController

  before_action :logged_in_user, only: [:create, :edit, :update]
  before_action :admin_user, only: :destroy



  def new
    if logged_in?
      @user = current_user
      @annotation = Annotation.new(user_id: @user.id, transcript_id: $tran_id)
    else
      logged_in_user
    end
  end
  def create
    @annotation = Annotation.new(annotation_params)
    if @annotation.save
      flash[:success] = "Great job! Transcript annotated"
      redirect_to "/transcripts/#{$tran_id}"
    else
      render :new
    end
  end

  def show
    @annotation = Annotation.find(params[:id])
    render layout: "annotations"
  end

private

  def annotation_params
    params.require(:annotation).permit(:comment, :link, :start, :end, :user_id, :transcript_id).merge(:user_id => current_user.id, :transcript_id => $tran_id)
  end

end
