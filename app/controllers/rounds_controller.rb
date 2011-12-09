class RoundsController < ApplicationController
  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = Round.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rounds }
    end
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
    @round = Round.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @round }
    end
  end

  # GET /rounds/new
  # GET /rounds/new.json
  def new
    @round = Round.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @round }
    end
  end

  # GET /rounds/1/edit
  def edit
    @round = Round.find(params[:id])
    @player1 = @round.game.player1
    @player2 = @round.game.player2
    @player3 = @round.game.player3
    @player4 = @round.game.player4
    @point1 = @round.points.find_by_user_id @player1.id
    @point2 = @round.points.find_by_user_id @player2.id
    @point3 = @round.points.find_by_user_id @player3.id
    @point4 = @round.points.find_by_user_id @player4.id
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = Round.new(params[:round])

    respond_to do |format|
      if @round.save
        format.html { redirect_to @round, notice: 'Round was successfully created.' }
        format.json { render json: @round, status: :created, location: @round }
      else
        format.html { render action: "new" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rounds/1
  # PUT /rounds/1.json
  def update
    # TODO in edit.html.erb, fill in the values of the points beforehand
    
    @round = Round.find(params[:id])
    
    point1 = @round.points.find_by_user_id @round.game.player1
    point2 = @round.points.find_by_user_id @round.game.player2
    point3 = @round.points.find_by_user_id @round.game.player3
    point4 = @round.points.find_by_user_id @round.game.player4
    
    # TODO: Store points before updating, so that if any fail, we can revert them
    
    point1.update_attributes(:amount => params[:player1_score])
    point2.update_attributes(:amount => params[:player2_score])
    point3.update_attributes(:amount => params[:player3_score])
    point4.update_attributes(:amount => params[:player4_score])
        
    # TODO: fail if the points do not update correctly
        
    respond_to do |format|
      if @round.update_attributes(params[:round])
        format.html { redirect_to @round.game, notice: 'Round was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round = Round.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to rounds_url }
      format.json { head :ok }
    end
  end
end
