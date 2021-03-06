class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    #@comments = Comment.all
    page_not_found
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    page_not_found
  end

  # GET /comments/new
  def new
    #@comment = Comment.new
    page_not_found
  end

  # GET /comments/1/edit
  def edit
    page_not_found
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        #format.html { render "show" }
        #format.js { render "ideas/_comment", status: :created, location: @comment }
        format.json { render :show, status: :created, location: @comment }
        IdeaChannel.broadcast_to(@comment.idea, render_comment(@comment))
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :idea_id)
    end
    
    # Render the comment for boradcast to make sure the layout is same as view output
    def render_comment(comment)
      ApplicationController.renderer.render(partial: 'ideas/comment', locals: {comment: comment})
    end
end
