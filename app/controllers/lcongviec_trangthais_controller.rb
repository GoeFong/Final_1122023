class LcongviecTrangthaisController < ApplicationController
  before_action :set_lcongviec_trangthai, only: %i[ show edit update destroy ]

  # GET /lcongviec_trangthais or /lcongviec_trangthais.json
  def index
    @lcongviec_trangthais = LcongviecTrangthai.all
  end

  # GET /lcongviec_trangthais/1 or /lcongviec_trangthais/1.json
  def show
  end

  def sort
    @lcongviec_trangthais = LcongviecTrangthai.find(params[:id])
    @lcongviec_trangthais.update(row_order_position: params[:row_order_position])
    head :no_content
  end
  
  # GET /lcongviec_trangthais/new
  def new
    @lcongviec_trangthai = LcongviecTrangthai.new
  end

  # GET /lcongviec_trangthais/1/edit
  def edit
  end

  # POST /lcongviec_trangthais or /lcongviec_trangthais.json
  def create
    @lcongviec_trangthai = LcongviecTrangthai.new(lcongviec_trangthai_params)

    respond_to do |format|
      if @lcongviec_trangthai.save
        format.html { redirect_to lcongviec_trangthai_url(@lcongviec_trangthai), notice: "Lcongviec trangthai was successfully created." }
        format.json { render :show, status: :created, location: @lcongviec_trangthai }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lcongviec_trangthai.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lcongviec_trangthais/1 or /lcongviec_trangthais/1.json
  def update
    respond_to do |format|
      if @lcongviec_trangthai.update(lcongviec_trangthai_params)
        format.html { redirect_to lcongviec_trangthai_url(@lcongviec_trangthai), notice: "Lcongviec trangthai was successfully updated." }
        format.json { render :show, status: :ok, location: @lcongviec_trangthai }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lcongviec_trangthai.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lcongviec_trangthais/1 or /lcongviec_trangthais/1.json
  def destroy
    @lcongviec_trangthai.destroy

    respond_to do |format|
      format.html { redirect_to lcongviec_trangthais_url, notice: "Lcongviec trangthai was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lcongviec_trangthai
      @lcongviec_trangthai = LcongviecTrangthai.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lcongviec_trangthai_params
      params.require(:lcongviec_trangthai).permit(:label, :gia_tri, :color)
    end
end
