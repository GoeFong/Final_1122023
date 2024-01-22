class VanbansController < ApplicationController
  before_action :authenticate_user!, expected: [:index,:show]
  before_action :quyen_xem, only: :show
  before_action :quyen_them, only: :new
  before_action :quyen_sua, only: :edit
  before_action :quyen_xoa, only: :destroy  
  before_action :set_vanban, only: %i[ show edit update destroy ]

  # GET /vanbans or /vanbans.json
  def index
    @pagy, @vanbans = pagy_countless( Vanban.all, items: 10)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /vanbans/1 or /vanbans/1.json
  def show
  end

  # GET /vanbans/new
  def new
    @vanban = Vanban.new
  end

  # GET /vanbans/1/edit
  def edit
  end

  # POST /vanbans or /vanbans.json
  def create
    @vanban = Vanban.new(vanban_params)
    @vanban.user = current_user
    respond_to do |format|
      if @vanban.save
        format.html { redirect_to vanbans_url, notice: "Vanban was successfully created." }
        format.json { render :show, status: :created, location: @vanban }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vanban.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vanbans/1 or /vanbans/1.json
  def update
    respond_to do |format|
      if @vanban.update(vanban_params)
        format.html { redirect_to vanbans_url, notice: "Vanban was successfully updated." }
        format.json { render :show, status: :ok, location: @vanban }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vanban.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vanbans/1 or /vanbans/1.json
  def destroy
    @vanban.destroy
    respond_to do |format|
      format.html { redirect_to vanbans_path, notice: "Vanban was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vanban
      @vanban = Vanban.friendly_id.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vanban_params
      params.require(:vanban).permit( :title, :level, :ghichu, :loaivanban ,:file_vanban,:donvi_id,:status )
    end

    def quyen_xem
      if !current_user.has_role?(:xem_vanban)
        redirect_to vanbans_url, notice: "Bạn không có quyền xem."
      end
    end
    def quyen_sua
      if !current_user.has_role?(:sua_vanban)
        redirect_to vanbans_url, notice: "Bạn không có quyền sửa."
      end
    end
    def quyen_xoa
      if !current_user.has_role?(:xoa_vanban)
        redirect_to vanbans_url, notice: "Bạn không có quyền xóa."
      end
    end
    def quyen_them
      if !current_user.has_role?(:them_vanban)
        redirect_to vanbans_url, notice: "Bạn không có quyền thêm."
      end
    end

end
