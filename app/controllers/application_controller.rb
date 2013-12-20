class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def session_count(location)
      # todo: the key should be count.location so we iterate over counts during reset_all_counts
      session[location] = 0 if session[location].nil?
      session[location] += 1
  end

  def reset_session_count(location)
      session[:store] = nil
  end


end
