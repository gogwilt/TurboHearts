class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
    @player1 = @game.player1
    @player2 = @game.player2
    @player3 = @game.player3
    @player4 = @game.player4

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :ok }
    end
  end
  
  def new_round
    @game = Game.find(params[:game_id])
    
    round = Round.new
    round.game = @game
    round.reporter = @game.player1
    round.save
    
    p1 = create_new_round_point(round, @game.player1, params[:player1_score])
    p2 = create_new_round_point(round, @game.player2, params[:player2_score])
    p3 = create_new_round_point(round, @game.player3, params[:player3_score])
    p4 = create_new_round_point(round, @game.player4, params[:player4_score])
    
    unless p1.save and p2.save and p3.save and p4.save
      p1.destroy
      p2.destroy
      p3.destroy
      p4.destroy
      round.destroy
    end
    
    respond_to do |format|
      format.html { redirect_to @game }
      format.json { head :ok }
    end
  end
  
  def create_new_round_point(round, player, amount)
    p = Point.new
    p.round = round
    p.user = player
    p.amount = amount
    return p
  end
  
  def new_game
    puts "hello world"
    @game = Game.new
    
    @game.player1 = find_or_create_new_player(params[:player1_name])
    @game.player2 = find_or_create_new_player(params[:player2_name])
    @game.player3 = find_or_create_new_player(params[:player3_name])
    @game.player4 = find_or_create_new_player(params[:player4_name])
    
    @game.save
    respond_to do |format|
      format.html { redirect_to @game }
      format.json { head :ok }
    end
  end
  
  def find_or_create_new_player(player_name)
    player = User.find_by_name(player_name)
    unless player
      player = User.create(:name => player_name)
    end
    return player
  end
end
