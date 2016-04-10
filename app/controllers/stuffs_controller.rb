class StuffsController < ApplicationController
  before_action :set_stuff, only: [:show, :edit, :update, :destroy]

  # GET /stuffs
  # GET /stuffs.json
  def index
    @stuffs = current_user.stuffs.all
  end

  # GET /stuffs/1
  # GET /stuffs/1.json
  def show
  end

  # GET /stuffs/new
  def new
    @stuff = current_user.stuffs.new
  end

  # GET /stuffs/1/edit
  def edit
  end

  # POST /stuffs
  # POST /stuffs.json
  def create
    @stuff = Stuff.new(stuff_params)
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def stuff_params
      #params.fetch(:stuff)
      params.require(:stuff).permit(:description, :target_url, :type, :user_id)
    end
end
