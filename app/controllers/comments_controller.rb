class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket

  def create
    # Build a new comment connected to this ticket
    @comment = @ticket.comments.build(comment_params)
    # Also connect comment to current user
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        # Normal fallback: just redirect back to ticket show page
        format.html { redirect_to @ticket, notice: "Comment added." }
        # Turbo: update comments section live (we'll set this up in views)
        format.turbo_stream
      end
    else
      redirect_to @ticket, alert: "Comment cannot be blank."
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
