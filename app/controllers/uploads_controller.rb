class UploadsController < ApplicationController
before_action :set_upload, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user
before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all.order(created_at: :desc)
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
     @user = @upload.user
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)

    respond_to do |format|
      if @upload.save
        format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
        format.json { render :show, status: :created, location: @upload }
      else
        format.html { render :new }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ensure_correct_user
    @upload = Upload.find_by(id: params[:id])
    if @upload.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/uploads")
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def upload_params
      params.require(:upload).permit(:image, :title, :body).merge(user_id: @current_user.id)
    end
end
