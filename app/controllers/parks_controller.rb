class ParksController < ApplicationController
  before_action :set_park, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :redirect_business

  # GET /parks
  # GET /parks.json
  def index
    @parks = Park.where(business_id: get_user_business.first.id)
    @amount_per_hour = Config.last.amount_per_hour
  end

  # GET /parks/1
  # GET /parks/1.json
  def show
    @amount = ((@park.time_end - @park.time_start) / 3600 ) * Config.last.amount_per_hour
  end

  # GET /parks/new
  def new
    @park = Park.new
  end

  # GET /parks/1/edit
  def edit

  end

  # POST /parks
  # POST /parks.json
  def create
    @park = Park.new(park_params)
    @park.business_id = get_user_business.first.id

    respond_to do |format|
      if @park.save
        format.html { redirect_to @park, notice: 'Park was successfully created.' }
        format.json { render :show, status: :created, location: @park }
      else
        format.html { render :new }
        format.json { render json: @park.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parks/1
  # PATCH/PUT /parks/1.json
  def update
    respond_to do |format|
      if @park.update(park_params)
        format.html { redirect_to @park, notice: 'Park was successfully updated.' }
        format.json { render :show, status: :ok, location: @park }
      else
        format.html { render :edit }
        format.json { render json: @park.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parks/1
  # DELETE /parks/1.json
  def destroy
    @park.destroy
    respond_to do |format|
      format.html { redirect_to parks_url, notice: 'Park was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_park
      @park = Park.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def park_params
      params.require(:park).permit(:number, :time_start, :time_end, :total_amount, :comments, :paid, :business_id)
    end
end

