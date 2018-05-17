class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :register]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def register
    @users_of_event = @event.users
  end

  def register_user
    @event = Event.find(params[:id])
    email = params[:email]
    user = User.where(email: email).take

    respond_to do |format|
      unless user.nil?
        if @event.users << user
          format.html { redirect_to register_to_event_path(@event), notice: 'User was successfully registered to event.' }
        else
          format.html { redirect_to register_to_event_path(@event), notice: "User couldn't be registered." }
        end
      else
        format.html { redirect_to register_to_event_path(@event), notice: "User does not exist." }
      end
    end

    # redirect_to register_to_event_path(@event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :start_date, :end_date, :max_students, :description)
    end
end
