class TicketsController < ApplicationController
  # Make sure user is logged in for any ticket page
  before_action :authenticate_user!

  # Before show/edit/update/destroy, find the ticket from DB
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets
  # Show list of tickets
  def index
    # If user is admin/agent → see all tickets
    # If normal customer → only see their own tickets
    @tickets =
      if current_user.admin? || current_user.agent?
        Ticket.all.order(created_at: :desc)
      else
        current_user.tickets.order(created_at: :desc)
      end
  end

  # GET /tickets/:id
  # Show one ticket and its comments
  def show
    @comment = Comment.new
  end

  # GET /tickets/new
  # Show empty form
  def new
    @ticket = Ticket.new
  end

  # POST /tickets
  # Handle form submit to create new ticket
  def create
    # Link ticket to the logged-in user
    @ticket = current_user.tickets.build(ticket_params)
    @ticket.status ||= :open

    if @ticket.save
      redirect_to @ticket, notice: "Ticket created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /tickets/:id/edit
  def edit
    unless can_edit?(@ticket)
      redirect_to tickets_path, alert: "You are not allowed to edit this ticket."
    end
  end

  # PATCH/PUT /tickets/:id
  def update
    unless can_edit?(@ticket)
      redirect_to tickets_path, alert: "You are not allowed to update this ticket." and return
    end

    if @ticket.update(ticket_params)
      redirect_to @ticket, notice: "Ticket updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tickets/:id
  def destroy
    unless current_user.admin? || current_user == @ticket.user
      redirect_to tickets_path, alert: "You are not allowed to delete this ticket." and return
    end

    @ticket.destroy
    redirect_to tickets_path, notice: "Ticket deleted."
  end

  private

  # Find ticket by id from URL
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  # Only allow these fields from form
  def ticket_params
    params.require(:ticket).permit(
      :title,
      :description,
      :status,
      :priority,
      :category,
      :assigned_to_id,
      attachments: []
    )
  end

  # Who is allowed to edit/update?
  def can_edit?(ticket)
    current_user.admin? || current_user.agent? || ticket.user == current_user
  end
end
