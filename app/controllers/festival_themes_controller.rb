class FestivalThemesController < ApplicationController

  before_filter :set_theme, :set_section
  skip_before_filter :check_launched
  layout :set_layout

  # GET /festival_themes
  # GET /festival_themes.json
  def index
    @festival_themes = FestivalTheme.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @festival_themes }
    end
  end

  # GET /festival_themes/1
  # GET /festival_themes/1.json
  def show
    @festival_theme = FestivalTheme.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @festival_theme }
    end
  end

  # GET /festival_themes/new
  # GET /festival_themes/new.json
  def new
    @festival_theme = FestivalTheme.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @festival_theme }
    end
  end

  # GET /festival_themes/1/edit
  def edit
    @festival_theme = FestivalTheme.find(params[:id])
  end

  # POST /festival_themes
  # POST /festival_themes.json
  def create
    @festival_theme = FestivalTheme.new(params[:festival_theme])

    respond_to do |format|
      if @festival_theme.save
        format.html { redirect_to @festival_theme, notice: 'Festival theme was successfully created.' }
        format.json { render json: @festival_theme, status: :created, location: @festival_theme }
      else
        format.html { render action: "new" }
        format.json { render json: @festival_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /festival_themes/1
  # PUT /festival_themes/1.json
  def update
    @festival_theme = FestivalTheme.find(params[:id])

    respond_to do |format|
      if @festival_theme.update_attributes(params[:festival_theme])
        format.html { redirect_to @festival_theme, notice: 'Festival theme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @festival_theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /festival_themes/1
  # DELETE /festival_themes/1.json
  def destroy
    @festival_theme = FestivalTheme.find(params[:id])
    @festival_theme.destroy

    respond_to do |format|
      format.html { redirect_to festival_themes_url }
      format.json { head :no_content }
    end
  end

protected
  def set_theme
    @theme = "events"
  end
  
  def set_section
    @section = "Settings"
  end

end
