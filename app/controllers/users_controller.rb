class UsersController < ApplicationController

  # Before_action is a 'before filter' that requires users to be logged
  # in (through the logged_in_user method) and for the user to be the
  # correct user before allowing edits
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  # The index method grabs all the users to post links to their pages
  def index
    @users = User.all
  end

  # The show method grabs the user with the id matching the page url?
  # @transcripts is set equal to all the transcripts of the @user. The
  # paginate method is run on @transcripts ?(not sure how this works)
  def show
    @user = User.find(params[:id])
    @transcripts = @user.transcripts.paginate(page: params[:page])
  end

  # The new and create methods make a user based on the attributes
  # defined in the private user_params method. If the user is
  # sucessfully created, the user is loged in through the log_in
  # function from the sessions helper, success flashes, and the user's
  # prof page is loaded.  If the registration fails, the new user page
  # reloads.
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      log_in @user
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  # The edit and update methods grab a user based on the url? id. The
  # update method runs the update_attributes method that takes in the
  # private user_params method and redirects to the user prof if
  # successful. If not sucessful, the edit page is re-rendered.
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  # This method grabs a viewer based on the url id. If the user is
  # sucessfully deleted, the app redirects the user page.
  def destroy
    @user = User.find(params[:id])
    redirect_to users_path if @user.destroy
  end

private
  # User_params requires that a user is dealt with and permit allows
  # you to edit and the attribute fields of user. You do it this way,
  # because you params[:user] returns a hash and you also don't want to
  # mess with all the params (like "id").
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :prof_pic_url, :party_id, :city, :state)
  end

  # If the user is logged in, return true. Otherwise, run the store_loc
  # method in the sessions helper, flash an error and send the user to
  # the login page
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user. Redirects to home page if current user is
  # not the user of the current prof page.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
