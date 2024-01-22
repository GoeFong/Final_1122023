class DonviUsersController < ApplicationController
    before_action :authenticate_user!, expected: [:index,:show]
    def new
      @donvi = Donvi.find(params[:donvi_id])
      @users_not_in_donvi = User.where.not(id: @donvi.users.pluck(:id))
      @donvi_user = @donvi.donvi_users.new
    end
  
    def create
      @donvi = Donvi.find(params[:donvi_id])
      @users_not_in_donvi = User.where.not(id: @donvi.users.pluck(:id))
      @donvi_user = @donvi.donvi_users.new(donvi_user_params)  # Thêm donvi_user_params
  
      if @donvi_user.save
        # Xử lý khi tạo thành công
        redirect_to @donvi
      else
        # Xử lý khi tạo không thành công
        render 'new'
      end
    end

    def edit
        @donvi_user = DonviUser.find(params[:id])
        @donvi = @donvi_user.donvi
        @users_not_in_donvi = User.where.not(id: @donvi.users.pluck(:id))
    end
  
    def update
        @donvi_user = DonviUser.find(params[:id])
        if @donvi_user.update(donvi_user_params)
            redirect_to @donvi_user.donvi, notice: 'Cập nhật thành công'
        else
            render 'edit'
        end
    end

    def destroy
        @donvi_user = DonviUser.find(params[:id])
        @donvi_user.destroy
        redirect_to  @donvi_user.donvi, alert: "Cán bộ đã được xóa thành công!"
        
    end

    private
  
    def donvi_user_params
      params.require(:donvi_user).permit(:user_id, :chucvu)
    end
  end
  