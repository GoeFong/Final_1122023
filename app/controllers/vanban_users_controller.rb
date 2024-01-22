class VanbanUsersController < ApplicationController
    before_action :authenticate_user!, expected: [:index,:show]


    def new
      @vanban = Vanban.find(params[:vanban_id])
      @donvi_users = Donvi.find(@vanban.donvi_id).users
      @vanban_users = @vanban.users

      @users = @donvi_users - @vanban_users

      @vanban_user = @vanban.vanban_users.new
    end
  
    def create
      @vanban = Vanban.find(params[:vanban_id])
      @donvi_users = Donvi.find(@vanban.donvi_id).users
      @vanban_users = @vanban.users

      @users = @donvi_users - @vanban_users
      @vanban_user = @vanban.vanban_users.new(vanban_user_params)  # Thêm vanban_user_params
  
      if @vanban_user.save
        # Xử lý khi tạo thành công
        redirect_to @vanban
      else
        # Xử lý khi tạo không thành công
        render 'new'
      end
    end

    def edit
        @vanban_user = VanbanUser.find(params[:id])
        @vanban = @vanban_user.vanban
        @donvi_users = Donvi.find(@vanban.donvi_id).users
        @vanban_users = @vanban.users

        @users = @donvi_users - @vanban_users
        
        # if(@users.present?)
        #   @users = User.find(@vanban_user.user_id)
        # end
    end
  
    def update
        @vanban_user = VanbanUser.find(params[:id])
        if @vanban_user.update(vanban_user_params)
            redirect_to @vanban_user.vanban, notice: 'Cập nhật thành công'
        else
            render 'edit'
        end
    end

    def destroy
        @vanban_user = VanbanUser.find(params[:id])
        @vanban_user.destroy
        redirect_to  @vanban_user.vanban, alert: "Cán bộ đã được xóa thành công!"
        
    end

    private
  
    def vanban_user_params
      params.require(:vanban_user).permit(:user_id, :role)
    end
  end
  