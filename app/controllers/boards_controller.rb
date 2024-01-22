class BoardsController < ApplicationController
    include ActionView::RecordIdentifier

    before_action :authenticate_user!, expected: [:index,:show]
    def index
       search
    end


    def sort
        @boards = LcongviecTrangthai.find(params[:id])
        @boards.update(row_order_position: params[:row_order_position])
        head :no_content
    end
      
    def search
        email_condition = "%#{current_user.email}%" 
        @congviecs =  Congviec.joins(:congviec_users).where('congviec_users.user_id = ? OR congviecs.guest_list ILIKE ?', current_user.id,email_condition).rank(:row_order)
        current_user.admin? ? boards = Board.all : boards = Board.where(congviecs: @congviecs).or(Board.where(user: current_user))
        @pagy, @boards = pagy_countless( boards , items: 4)
        # params[:vanban_id].present? ? @vanban = Vanban.find(params[:vanban_id]) : @vanban = nil
        # @vanban.present? ? @congviecs = @vanban.congviecs.rank(:row_order) : @congviecs = nil
        # @congviecs.present? ? @congviec_users = @vanban.congviec_users : @congviec_users = nil
        # @list = LcongviecTrangthai.rank(:row_order)
        # @congviec_trangthai = {}

        # if @congviecs.present?
        #     @list.each do |tt|
        #     @congviec_trangthai[tt.gia_tri] = []

        #     @congviecs.each do |cv|
        #         if cv.lcongviec_trangthai.gia_tri == tt.gia_tri
        #         @congviec_trangthai[tt.gia_tri] << cv
        #         end
        #     end
        #     end
            
        # end
        render "index"
    end

    def new_congviec
        @lcongviec_trangthai = LcongviecTrangthai.all
        @trangthai_label
        @lcongviec_trangthai.each do |t|
            if t.gia_tri == params[:trangthai_cv]
                @trangthai_label = t
            end
        end

        @vanban = Vanban.find(params[:vanban_id])
        @users =  @vanban.users
        @congviecs = @vanban.congviecs.new
    end

    def new
        @board = Board.new
    end

    def create
        @board = Board.new(board_params)

        if @board.save
            redirect_to boards_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @board = Board.find(params[:id])
    end

    def update

        email_condition = "%#{current_user.email}%" 
        @board = Board.find(params[:id])
        @congviecs =  Congviec.joins(:congviec_users).where('congviec_users.user_id = ? OR congviecs.guest_list ILIKE ?', current_user.id,email_condition).rank(:row_order)

        respond_to do |format|
            if @board.update(board_params)
              # current_user.add_role :sua_donvi
      
             format.turbo_stream {render turbo_stream: turbo_stream.replace("#{dom_id @board}", partial: "boards/board", locals: { board: @board }) }
              
            else
              format.html { render :edit, status: :unprocessable_entity }
              format.json { render json: @board.errors, status: :unprocessable_entity }
            end
          end
    end


    def destroy
        @board = Board.find(params[:id])
        @board.destroy
    
        respond_to do |format|
          format.html { redirect_to boards_path, notice: "Congviec was successfully destroyed." }
          format.json { head :no_content }
        end
      end

    def create_congviec
        params_cv = vanban_congviec_user_params

        if params_cv[:start_date_between]
          starts_str = params_cv[:start_date_between].split(" - ").first
          starts = Date.strptime(starts_str, '%m/%d/%Y')
          ends_str = params_cv[:start_date_between].split(" - ").last
          ends = Date.strptime(ends_str, '%m/%d/%Y')

        end
      
        @vanban = Vanban.find(params_cv[:vanban_id])
      
        # Tạo công việc mới trong bảng congviecs
        @congviecs = @vanban.congviecs.new(
          macongviec: "CV" + SecureRandom.hex(4),
          ngay_bd: starts,
          ngay_kt: ends,
          lcongviec_trangthai_id: params_cv[:lcongviec_trangthai_id],
          them_cb: params_cv[:them_cb],
          noidung: params_cv[:noidung]
        )
        respond_to do |format|

            if @congviecs.save
            # Tạo các bản ghi congviec_users trong bảng congviec_users
            #   user_ids = params.require(:congviec).permit(user_ids: [])[:user_ids]
                user_ids = params_cv[:user_ids]
                if @congviecs.them_cb?
                    user_ids.each do |user_id|
                        @vanban.congviec_users.create(user_id: user_id, congviec_id: @congviecs.id, vanban_id: @vanban.id)
                    end
               end
                    format.html
                    format.turbo_stream {redirect_to search_boards_path(vanban_id: @vanban.id), notice: "Công việc và người dùng đã được tạo thành công."}
            else
            render :new
            end
        end

    end
      
    
    def them_lich
        @congviec = Congviec.find(params[:id])
        respond_to do |format|
            format.html
            format.ics do
                calendar = Congviecs::IcalendarEvent.new(congviec: @congviec).call
                send_data calendar.to_ical, type: 'text/calendar', disposition: 'attachment', filename: "Congviec_#{@congviec.macongviec}.ics"
                # render plain: @congviec.to_icalendar, filename: "#{@congviec.macongviec}"
            end
        end
    end
    

    private
    def set_board
        @board = Board.find(params[:board_id])
    end
    def vanban_congviec_user_params
        params.require(:congviec).permit(:lcongviec_trangthai_id, :vanban_id, :noidung,:them_cb ,:start_date_between,user_ids:[])
    end
    
    def board_params
        params.require(:board).permit(:name, :user_id)
    end
end