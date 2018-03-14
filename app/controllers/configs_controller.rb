class ConfigsController < ApplicationController
  before_action :set_config, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :redirect_business

  # GET /configs
  # GET /configs.json
  def index
    business = Business.where(user: current_user.id).last
    if !business.nil?
      @configs = Config.where(business_id: business.id)
    else
      @configs = []
    end
  end

  # GET /configs/1
  # GET /configs/1.json
  def show
    check_access_config params[:id]
  end

  # GET /configs/new
  def new
    # check if business has first been created
    business = Business.where(user: current_user.id).count
    if business > 0
      @config = Config.new
    else
      flash[:error] = "Create Business First"
      redirect_to businesses_url
    end
  end

  # GET /configs/1/edit
  def edit
  end

  # POST /configs
  # POST /configs.json
  def create
    @config = Config.new(config_params)
    @config.business_id = get_user_business.first.id

    respond_to do |format|
      if @config.save
        format.html { redirect_to @config, notice: 'Config was successfully created.' }
        format.json { render :show, status: :created, location: @config }
      else
        format.html { render :new }
        format.json { render json: @config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /configs/1
  # PATCH/PUT /configs/1.json
  def update
    respond_to do |format|
      if @config.update(config_params)
        format.html { redirect_to @config, notice: 'Config was successfully updated.' }
        format.json { render :show, status: :ok, location: @config }
      else
        format.html { render :edit }
        format.json { render json: @config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /configs/1
  # DELETE /configs/1.json
  def destroy
    @config.destroy
    respond_to do |format|
      format.html { redirect_to configs_url, notice: 'Config was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def check_access_config param_id
      business = Business.where(id: current_user.id).last
      config = Config.where(business_id: business).last
      # if length zero redirect_to config
      unless config == param_id
        redirect_to configs_url
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_config
      @config = Config.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def config_params
      params.require(:config).permit(:amount_per_hour, :business_id)
    end
end
