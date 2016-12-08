class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  #Check login for all connection
  before_action :require_login
  
  def require_login
    unless logged_in
      #flash[:error] = "Please login to access the page!"
	  #record current URL before redirect to login page
	  session[:return_to] = request.url
      redirect_to url_for(:controller => :sessions, :action => :index)
    end
  end
  	
  def logged_in
    true if session[:logged_in] == true
  end
  
  #Redirect to URL which user enter
  def redirect_back_or_default(default)
    redirect_to(session.delete(:return_to) || default)
  end
  
  #All http error will return as 404 error for security result
  def permission_denied
    #render :file => "public/401.html", :status => :unauthorized
    page_not_found
  end
  
  #Return unauthorized error
  def page_not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
