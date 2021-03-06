class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.where(user: current_user.id)
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    check_user_access params[:id]
  end

  # GET /businesses/new
  def new
    business = Business.where(user: current_user.id)
    if business.length === 0
      @business = Business.new
    else
      redirect_to businesses_url
    end
  end

  # GET /businesses/1/edit
  def edit
    check_user_access params[:id]
  end

  # POST /businesses
  # POST /businesses.json
  def create
    @business = Business.new(business_params)
    @business.user = current_user

    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { render :show, status: :ok, location: @business }
      else
        format.html { render :edit }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def check_user_access param_id
      @business = Business.where(id: param_id).last
      unless @business.user_id == current_user.id
        redirect_to businesses_url
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:name, :location)
    end
end
