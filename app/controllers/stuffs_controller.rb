class StuffsController < ApplicationController

  load_and_authorize_resource

  before_action :set_stuff, only: [:show, :edit, :update, :destroy]
  before_action :set_owner, only: :index

  # GET /stuffs
  # GET /stuffs.json
  def index
    @stuffs = @owner.stuffs.all
  end

  # GET /stuffs/1
  # GET /stuffs/1.json
  def show
  end

  # GET /stuffs/new
  def new
    @stuff = current_user.stuffs.new stuff_params
  end

  # GET /stuffs/1/edit
  def edit
  end

  # POST /stuffs
  # POST /stuffs.json
  def create
    @stuff = current_user.stuffs.new(stuff_params)
    if @stuff.save
      redirect_to stuffs_path, notice: 'Stuff was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /stuffs/1
  # PATCH/PUT /stuffs/1.json
  def update
    respond_to do |format|
      if @stuff.update(stuff_params)
        format.html { redirect_to @stuff, notice: 'Stuff was successfully updated.' }
        format.json { render :show, status: :ok, location: @stuff }
      else
        format.html { render :edit }
        format.json { render json: @stuff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stuffs/1
  # DELETE /stuffs/1.json
  def destroy
    @stuff.destroy
    respond_to do |format|
      format.html { redirect_to stuffs_url, notice: 'Stuff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stuff
      @stuff = Stuff.find(params[:id])
    end

    def set_owner
      @owner = params[:user_id].present? ? User.find_by_nickname(params[:user_id]) : current_user
      redirect_to :root if @owner.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stuff_params
      params.permit(stuff: [:description, :picture, :target_url, :type, :user_id])[:stuff]
    end
end
