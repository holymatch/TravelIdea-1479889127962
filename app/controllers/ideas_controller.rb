class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :owner, only: [:edit, :update, :destroy]

  # GET /ideas
  # GET /ideas.json
  def index
    @idea = Idea.new
    if params[:keyword]
      # new ideas will show in the top of page
      @ideas = Idea.search(params[:keyword]).order(created_at: :desc)
    else 
      @ideas = Idea.all.order(created_at: :desc)
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @comment = Comment.new
    # create a empty array if not hotel return
    @hotels = []
    begin
      response = HTTParty.get("http://api.hotwire.com/v1/deal/hotel?dest=#{URI.encode(@idea.destination)}&currency=USD&apikey=cg54gruz8zva5n67p6jnqu8b&limit=5&sort=price&sortorder=desc&format=JSON", {format: :json})
      if response.code and response["Errors"].size == 0
        @hotels = response["Result"]
      end
    rescue HTTParty::Error => e
      logger.debug("HTTParty Error: #{e}")
    rescue StandardError => e
      logger.debug("Fail to get hotel list: #{e}")
    end
  end

  # GET /ideas/new
  def new
    #@idea = Idea.new
    page_not_found
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(idea_params)
    @idea.user = User.find(session[:user_id])
    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        #format.json { render :show, status: :created, location: @idea }
        # redirect to new idea page after create idea success
        format.json { redirect_to @idea, notice: 'Idea was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:title, :destination, :start_date, :end_date, :tags, :user_id)
    end
    
    # only owner can change the record
    def owner
      permission_denied unless session[:user_id] == @idea.user_id
    end
end
