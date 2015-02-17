class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @orderby = params.has_key?(:orderby) ? (session[:orderby] = params[:orderby]) : session[:orderby] 
    
    @all_ratings = Movie.ratings_cache
        
    if params.has_key? :commit then
      if params.has_key? :ratings then 
        @filter = session[:filter] = params[:ratings].keys
      else
        flash.keep
        redirect_to :filter => @filter, :orderby => @orderby
        return
      end
    else
          

      if !params.has_key? :filter  then
        if session[:filter] then
          @filter = session[:filter] 
          flash.keep
          redirect_to :filter => @filter, :orderby => @orderby
          return
        else
          @filter = session[:filter] = @all_ratings.keys 
        end
      else
        @filter = params[:filter]
      end  
    
    end
       
    @movies = Movie.where( :rating => @filter ).order( @orderby ).all

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
