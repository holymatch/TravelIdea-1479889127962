class SessionsController < ApplicationController
  before_action :set_user, only: [:index]
  # Skip login action on login page
  skip_before_action :require_login, only: [:index, :new]
  
  # GET /login
  def index
    if logged_in
	  redirect_back_or_default("/")
	end
  end
  
  # POST /login
  def new
    @user = User.find_by_email(params[:email])
	if @user && @user.authenticate(params[:password])
	  return_to = session[:return_to]
	  reset_session
	  session[:user_id] = @user.id
	  session[:user_first_name] = @user.first_name
	  session[:user_last_name] = @user.last_name
	  session[:logged_in] = true
	  session[:return_to] = return_to
    cookies.signed[:user_id] = @user.id
	  redirect_back_or_default("/")
	else
	  flash[:error] = 'Invalid email/password combination' # Not quite right!
    render "index"
	end
  end
  
  # GET /logout
  def destroy
  cookies.delete :user_id
	reset_session
	redirect_back_or_default("/")
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_email(params[:email])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
