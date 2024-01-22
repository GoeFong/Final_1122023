class DonvisController < ApplicationController
  before_action :authenticate_user!
  before_action :quyen_xem, only: :show
  before_action :quyen_them, only: [:new, :new2]
  before_action :quyen_sua, only: :edit
  before_action :quyen_xoa, only: :destroy  
  before_action :set_donvi, only: %i[ show edit update destroy ]
  # GET /donvis or /donvis.json
  def index
    @donvis = Donvi.all
  end

  # GET /donvis/1 or /donvis/1.json
  def show
  end

  # GET /donvis/new
  def new
    @donvi = Donvi.new donvi_params
  end

  def new2
    @donvi = Donvi.new donvi_params
  end

  # GET /donvis/1/edit
  def edit
  end

  # POST /donvis or /donvis.json
  def create
      @donvi = Donvi.new(donvi_params)
      respond_to do |format|
        if @donvi.save
          # current_user.add_role :them_donvi
          format.html { redirect_to donvi_url(@donvi), notice: "Donvi was successfully created." }
          format.json { render :show, status: :created, location: @donvi }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @donvi.errors, status: :unprocessable_entity }
        end
      end

  end

  def create2
      @donvi = Donvi.new(donvi_params)
      respond_to do |format|
        if @donvi.save
          format.html { redirect_to new_vanban_path, notice: "Donvi was successfully created." }
          format.json { render :show, status: :created, location: @donvi }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @donvi.errors, status: :unprocessable_entity }
        end
      end
    

  end

  # PATCH/PUT /donvis/1 or /donvis/1.json
  def update
      
      respond_to do |format|
        if @donvi.update(donvi_params)
          # current_user.add_role :sua_donvi
  
          format.html { redirect_to donvi_url(@donvi), notice: "Donvi was successfully updated." }
          format.json { render :show, status: :ok, location: @donvi }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @donvi.errors, status: :unprocessable_entity }
        end
      end
    
  end

  # DELETE /donvis/1 or /donvis/1.json
  def destroy
      @donvi.destroy
      # current_user.add_role :xoa_donvi

      respond_to do |format|
        format.html { redirect_to donvis_url, notice: "Donvi was successfully destroyed." }
        format.json { head :no_content }
      end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donvi
      @donvi = Donvi.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def donvi_params
      params.fetch(:donvi, {}).permit(:ten, :country, :state, :city, :sdt, :email, :status)
    end
    
    def quyen_xem
      if !current_user.has_role?(:xem_donvi)
        redirect_to donvis_url, notice: "Bạn không có quyền xem."
      end
    end
    def quyen_sua
      if !current_user.has_role?(:sua_donvi)
        redirect_to donvis_url, notice: "Bạn không có quyền sửa."
      end
    end
    def quyen_xoa
      if !current_user.has_role?(:xoa_donvi)
        redirect_to donvis_url, notice: "Bạn không có quyền xóa."
      end
    end
    def quyen_them
      if !current_user.has_role?(:them_donvi)
        redirect_to donvis_url, notice: "Bạn không có quyền thêm."
      end
    end
end
