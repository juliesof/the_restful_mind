class UsersController < ApplicationController

  def show
    @user = User.find_by(id: current_user)
    @sitting_info = @user.sittings
  end
end
