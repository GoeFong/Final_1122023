class XemcongviecsController < ApplicationController

    def index
        email_condition = "%#{current_user.email}%" 

        current_user.admin? ? @congviecs = Congviec.all : @congviecs =  Congviec.joins(:congviec_users).where('congviec_users.user_id = ? OR congviecs.guest_list ILIKE ?', current_user.id,email_condition).rank(:row_order)
        @q = @congviecs.ransack(params[:q])

        
        if  @q.created_at_gteq.present?
            @q.created_at_gteq =  @q.created_at_gteq 
        end
    
        if @q.created_at_lteq.present?
            @q.created_at_lteq = @q.created_at_lteq 
        end
        # if params[:q] && params[:q][:users_cv_name_cont].present?
        #     # Thêm điều kiện tìm kiếm theo tên người dùng
        #     @q = @q.joins(congviec_users: :user).merge(User.ransack(name_cont: params[:q][:users_cv_name_cont]))
        # end
        # byebug
        # @people = @q.result.includes(:articles).page(params[:page])
        Rails.logger.info @q.inspect # Xem điều kiện tìm kiếm trong log
        @pagy, @congviecs = pagy_countless(@q.result.includes(:lcongviec_trangthai), items: 6)
    end
end