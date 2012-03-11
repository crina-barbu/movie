class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
      if params.has_value?('title')
          @movies = Movie.all(:order => 'title')
          @sort = 'title'
      elsif params.has_value?('date')
          @movies = Movie.all(:order => 'release_date')
          @sort = 'date'
      else
          @movies = Movie.all
      end
      @all_ratings = Movie.get_ratings
      @rate = Hash.new
      for i in 0..@all_ratings.length-1 do
        @rate[@all_ratings[i]] = false
      end
      
      if params[:ratings]
        @i = 0
        @k = 0
        @aux = Array.new
        @checked_ratings = params[:ratings]
        @checked_ratings.each do |r, v|
          mov = Movie.all(:conditions => "rating = '#{r}'")
          mov.each do |m|
            @aux[@i] = m
            @i +=1
          end
          @rate[r] = true
        end
        @movies = @aux
        
        @k += 1
      end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
