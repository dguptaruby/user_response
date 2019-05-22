class UsersController < ApplicationController

  def home
    if params[:username].present?
      @user = User.where("username like ?", "%#{params['username']}%").first
    end
  end

  def user_search
    if params[:username].present?
      @user = User.where("username like ?", "%#{params['username']}%").first
      @user_acc_per = @user.user_per_of_week(params[:daterange])
      if @user_acc_per.nil?
        flash[:notice] = "No question response present for selected date."
        redirect_to user_search_path and return
      end
      @all_user = @user.acc_per_of_week(params[:daterange], @user_acc_per)
      @all_user = @all_user.rows.paginate(:page => params[:page], :per_page => 25)
    end
  end

end
