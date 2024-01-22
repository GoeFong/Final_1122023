class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :quyen_sua, only: :edit
    def index
        @users = User.all.order(id: :asc)
    end
  
    def edit
    @user = User.find(params[:id])
    end

    def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.update(user_params)
        redirect_to users_url, notice: "User was successfully updated."
    else
        render :edit
    end
    end

    private

    def user_params
        params.require(:user).permit({role_ids: []})
    end

    def quyen_sua
        if !current_user.has_role?(:capnhat_quyencb)
            redirect_to users_url, notice: "Bạn không có quyền cập nhật."
        end
    end
  end