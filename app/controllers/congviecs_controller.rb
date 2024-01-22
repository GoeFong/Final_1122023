class CongviecsController < ApplicationController
  before_action :set_congviec, only: %i[ show edit update destroy sync_event_with_google]
  before_action :authenticate_user!


  # GET /congviecs or /congviecs.json
  def index
    @congviecs =  Congviec.joins(:congviec_users).where('congviec_users.id = ?', current_user.id)
  end

  # GET /congviecs/1 or /congviecs/1.json
  def show
    @user_congviec = @congviec.congviec_users.where( congviec_id: @congviec.id)
    mark_notifications_as_read
  end

  def show_congviec
    @congviec = Congviec.find(params[:id])
    @user_congviec = @congviec.congviec_users.where( congviec_id: @congviec.id)
    mark_notifications_as_read
  end

  def sort
    @board = Board.find(params[:board_id])
    @congviec =  @board.congviecs.find(params[:id])
    @congviec.update(row_order_position: params[:row_order_position], board_id: params[:list_id])
    head :no_content
    
  end

  def invite
    @congviec = Congviec.find(params[:id])
    CongviecMailer.with(congviec: @congviec).invite.deliver_now
    redirect_to boards_path, notice: 'Lời mời đã được gửi'
  end

  def check_prefix_congviec
    prefix_congviec = params[:prefix_congviec]
    existing_prefix = Congviec.find_by(macongviec: prefix_congviec)

    if existing_prefix
      render json: { message: "Đã tồn tại giá trị này" }
    else
      render json: { message: "Có thể sử dụng" }
    end
  end

  # GET /congviecs/new
  def new
    @users = User.where.not(id: current_user.id)
    @congviec = board.congviecs.new
  end

  def new_congviec
    @users = User.where.not(id: current_user.id)
    @congviec = Congviec.new
  end
  def create_congviec
    
    params_cv = congviec_params
    @users = User.where.not(id: current_user.id)

    if params_cv[:start_date_between]
      starts_str = params_cv[:start_date_between].split(" - ").first
      starts = DateTime.strptime(starts_str, '%d-%m-%Y %H:%M:%S')
      ends_str = params_cv[:start_date_between].split(" - ").last
      ends = DateTime.strptime(ends_str, '%d-%m-%Y %H:%M:%S')

    end
    
    # Tạo công việc mới trong bảng congviecs
    @congviec = Congviec.new(
      macongviec: params_cv[:prefix_congviec],
      ngay_bd: starts,
      ngay_kt: ends,
      lcongviec_trangthai_id: params_cv[:lcongviec_trangthai_id],
      them_cb: params_cv[:them_cb],
      user_id: params_cv[:user_id],
      vanban_id: params_cv[:vanban_id],
      noidung: params_cv[:noidung],
      guest_list: params_cv[:guest_list],
      diachi: params_cv[:diachi]
    )
    # byebug
    respond_to do |format|
      if @congviec.save
        # Tạo các bản ghi congviec_users trong bảng congviec_users
        #   user_ids = params.require(:congviec).permit(user_ids: [])[:user_ids]
            user_ids = params_cv[:user_ids]
            if @congviec.them_cb?
                user_ids.each do |user_id|
                    @congviec.congviec_users.create(user_id: user_id, congviec_id: @congviec.id)
                end
           end
           format.html { redirect_to xemcongviecs_path, notice: "Congviec was successfully created." }
           format.json { render :show, status: :created, location: @congviec }
         else
          #  format.html { render :new, status: :unprocessable_entity }
           format.turbo_stream { render :new, status: :unprocessable_entity }
        end
    end
    rescue Google::Apis::ClientError => error
      redirect_to xemcongviecs_path, notice: error.message
  end
  # GET /congviecs/1/edit
  def edit
    @users = User.where.not(id: current_user.id)
  end
  def edit_congviec
    @users = User.where.not(id: current_user.id)
  end

  # POST /congviecs or /congviecs.json
  def create
    
    params_cv = congviec_params
    @users = User.where.not(id: current_user.id)

    if params_cv[:start_date_between]
      starts_str = params_cv[:start_date_between].split(" - ").first
      starts = DateTime.strptime(starts_str, '%d-%m-%Y %H:%M:%S')
      ends_str = params_cv[:start_date_between].split(" - ").last
      ends = DateTime.strptime(ends_str, '%d-%m-%Y %H:%M:%S')

    end
    
    # Tạo công việc mới trong bảng congviecs
    @congviec = board.congviecs.new(
      macongviec: params_cv[:prefix_congviec],
      ngay_bd: starts,
      ngay_kt: ends,
      lcongviec_trangthai_id: params_cv[:lcongviec_trangthai_id],
      them_cb: params_cv[:them_cb],
      user_id: params_cv[:user_id],
      vanban_id: params_cv[:vanban_id],
      noidung: params_cv[:noidung],
      guest_list: params_cv[:guest_list],
      diachi: params_cv[:diachi]
    )
    # byebug
    respond_to do |format|
      if @congviec.save
        # Tạo các bản ghi congviec_users trong bảng congviec_users
        #   user_ids = params.require(:congviec).permit(user_ids: [])[:user_ids]
            user_ids = params_cv[:user_ids]
            if @congviec.them_cb?
                user_ids.each do |user_id|
                    @congviec.congviec_users.create(user_id: user_id, congviec_id: @congviec.id)
                end
           end
           format.html { redirect_to boards_path, notice: "Congviec was successfully created." }
           format.json { render :show, status: :created, location: @congviec }
         else
          #  format.html { render :new, status: :unprocessable_entity }
          format.turbo_stream { render :new, status: :unprocessable_entity }

        end
    end
    rescue Google::Apis::ClientError => error
      redirect_to boards_path, notice: error.message
  end

  # PATCH/PUT /congviecs/1 or /congviecs/1.json
  def update_congviec
    # byebug
    params_cv = congviec_params
    @users = User.where.not(id: current_user.id)

    if params_cv[:start_date_between]
      starts_str = params_cv[:start_date_between].split(" - ").first
      starts = DateTime.strptime(starts_str, '%d-%m-%Y %H:%M:%S')
      ends_str = params_cv[:start_date_between].split(" - ").last
      ends = DateTime.strptime(ends_str, '%d-%m-%Y %H:%M:%S')

    end
    respond_to do |format|
      if @congviec.update(
        macongviec: params_cv[:prefix_congviec],
        ngay_bd: starts,
        ngay_kt: ends,
        lcongviec_trangthai_id: params_cv[:lcongviec_trangthai_id],
        them_cb: params_cv[:them_cb],
        user_id: params_cv[:user_id],
        vanban_id: params_cv[:vanban_id],
        noidung: params_cv[:noidung],
        guest_list: params_cv[:guest_list],
        diachi: params_cv[:diachi]
      )
          
        format.html { redirect_to board_congviec_url(@board,@congviec), notice: "Congviec was successfully updated." }
        format.json { render :show, status: :ok, location: @congviec }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @congviec.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # byebug
    params_cv = congviec_params
    @users = User.where.not(id: current_user.id)

    if params_cv[:start_date_between]
      starts_str = params_cv[:start_date_between].split(" - ").first
      starts = DateTime.strptime(starts_str, '%d-%m-%Y %H:%M:%S')
      ends_str = params_cv[:start_date_between].split(" - ").last
      ends = DateTime.strptime(ends_str, '%d-%m-%Y %H:%M:%S')

    end
    respond_to do |format|
      if @congviec.update(
        macongviec: params_cv[:prefix_congviec],
        ngay_bd: starts,
        ngay_kt: ends,
        lcongviec_trangthai_id: params_cv[:lcongviec_trangthai_id],
        them_cb: params_cv[:them_cb],
        user_id: params_cv[:user_id],
        vanban_id: params_cv[:vanban_id],
        noidung: params_cv[:noidung],
        guest_list: params_cv[:guest_list],
        diachi: params_cv[:diachi]
      )
          
        format.html { redirect_to board_congviec_url(@board,@congviec), notice: "Congviec was successfully updated." }
        format.json { render :show, status: :ok, location: @congviec }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @congviec.errors, status: :unprocessable_entity }
      end
    end
  end

  def sync_event_with_google
    ge = @congviec.get_google_event(@congviec.google_event_id, @congviec.user_giamsat)
    guests = ge.attendees.map {|at| at.email}.join(", ")
    @congviec.update(guest_list: guests)
    redirect_to boards_path, notice: "Event has been synced with google successfully."
  end

  # DELETE /congviecs/1 or /congviecs/1.json
  def destroy
    @congviec.destroy

    respond_to do |format|
      format.html { redirect_to boards_path, notice: "Congviec was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def destroy_congviec
    @congviec = Congviec.find(params[:id])
    @congviec.destroy

    respond_to do |format|
      format.html { redirect_to boards_path, notice: "Congviec was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_congviec
      @board = Board.find(params[:board_id])
      @congviecs = @board.congviecs.rank(:row_order)
      @congviec = @congviecs.find(params[:id])
    end

    def board
      @board = Board.find(params[:board_id])
    end
    # Only allow a list of trusted parameters through.
    def congviec_params
      params.require(:congviec).permit(:prefix_congviec,:lcongviec_trangthai_id,:user_id,:vanban_id, :guest_list, :macongviec, :noidung,:them_cb,:diachi ,:start_date_between,user_ids:[])
    end

    def mark_notifications_as_read
      if current_user
        notifications_to_mark_as_read = @congviec.notifications_as_congviec.where(recipient: current_user)
        notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
      end
    end
end
