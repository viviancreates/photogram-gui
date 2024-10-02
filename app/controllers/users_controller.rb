class UsersController < ApplicationController

  def index
    matching_users = User.all

    @list_of_users = matching_users.order ({ :username => :asc })

    render ({ :template => "user_templates/index" })
  end

  def show
    # Parameters: {"path_username"=>"anisa"}
    url_username = params.fetch("path_username")
    matching_usernames = User.where({ :username => url_username })
    @the_user = matching_usernames.first
    render ({ :template => "user_templates/show" })
  end

  def create
    new_user = User.new
    new_user.username = params.fetch("username")
    new_user.save
    redirect_to("/users/"+ new_user.username.to_s)
  end
end
