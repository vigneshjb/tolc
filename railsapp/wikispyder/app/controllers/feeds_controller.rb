class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :chk_usr_login, only: [:index]

  # GET /feeds
  # GET /feeds.json
  def index
    interests = current_user.interest.split(',')
    @feeds = []
    interests.each { |int| @feeds+=Feed.where("interest"=>int) }
    @feeds = @feeds.sort_by(&:updated_at).reverse
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  #GET /feeds/1/upvote
  def upvote
    @feed.up_vote_count = @feed.up_vote_count+1
    if @feed.save 
        render :text => "Upvote saved"
    else
        render :text => "Upvote failed"
    end
  end

  #GET /feeds/1/downvote
  def downvote
    @feed.down_vote_count = @feed.down_vote_count+1
    if @feed.save 
        render :text => "Downvote saved"
    else
        render :text => "Downvote failed"
    end
  end

  # POST /feeds
  # POST /feeds.json
  def create
    @feed = Feed.new(feed_params)
    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  # PATCH/PUT /feeds/1.json
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feed_params
      params.require(:feed).permit(:user_id, :up_vote_count, :down_vote_count, :feed_type, :feed_content, :interest)
    end

    #chk for login 
    def chk_usr_login
      if !user_signed_in?
        redirect_to root_path
      end
    end
end
