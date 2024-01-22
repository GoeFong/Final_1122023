class CongviecUsersController < ApplicationController
    before_action :authenticate_user!, expected: [:index,:show]
    def new
        @board = Board.find(params[:board_id])
        @congviec = Congviec.find(params[:congviec_id])
        # @congviecs = @board.congviecs.rank(:row_order)
        @users =  User.all - @congviec.users_cv

        @congviec_user = @congviec.congviec_users.new
    end

    def new_congviec_user
        @congviec = Congviec.find(params[:id])
        # @congviecs = @board.congviecs.rank(:row_order)
        @users =  User.all - @congviec.users_cv

        @congviec_user = @congviec.congviec_users.new
    end
  
    def create_congviec_user
        @congviec = Congviec.find(params[:id])
        # @congviecs = @board.congviecs.rank(:row_order)
        @users =  User.all - @congviec.users_cv

        @congviec_user = @congviec.congviec_users.new(congviec_user_params)
        if @congviec_user.save
            # Xử lý khi tạo thành công
            redirect_to show_congviec_path(@congviec)
        else
            # Xử lý khi tạo không thành công
            render 'new_congviec_user'
        end
    end

    def create
        @board = Board.find(params[:board_id])
        @congviec = Congviec.find(params[:congviec_id])
        # @congviecs = @board.congviecs.rank(:row_order)
        @users =  User.all - @congviec.users_cv

        @congviec_user = @congviec.congviec_users.new(congviec_user_params)
        if @congviec_user.save
            # Xử lý khi tạo thành công
            redirect_to board_congviec_path(@board,@congviec)
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
        if @donvi_user.update(congviec_user_params)
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
  
    def congviec_user_params
      params.require(:congviec_user).permit(:user_id)
    end
  end
  