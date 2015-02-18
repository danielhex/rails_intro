class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # @all_ratings = Movie.get_ratings.keys

    # if (!params.has_key? :sorting) && (!params.has_key? :ratings) && (session.has_key? :sorting) || (session.has_key? :ratings)
    #   redirect_to movies_path(:sorting => session[:sorting], :ratings => session[:ratings])
    # end
    # if params.has_key?(:sorting) 
    #   @sorting = params[:sorting]
    # end
    # @ratings = params[:ratings]
    # if (@ratings != nil)
    #   ratings = @ratings.keys
    #   session[:ratings] = @ratings
    # else
    #   if ((!params.has_key? :commit) && (!params.has_key? :sorting))
    #     ratings = Movie.get_ratings.keys
    #     session[:ratings] = Movie.get_ratings
    #   else
    #     ratings = session[:ratings].keys
    #   end
    # end

    # session[:sorting] = @sorting
    

    # @movies = Movie.order(@sorting).find_all_by_rating(ratings)

    if(params[:sorting] == nil && params[:ratings] == nil)
      if(session[:sorting] != nil || session[:ratings] != nil)
        redirect_to movies_path(:sorting =>session[:sorting], :ratings=>session[:ratings])
      end
    end
    
    @sorting = params[:sorting]
    if params.has_key?(:sorting) 
      @sorting = params[:sorting]
    end
    session[:sorting] = @sorting

    @all_ratings = Movie.get_ratings.keys
    @ratings = params[:ratings]
    if(@ratings != nil)
      ratings = @ratings.keys
      session[:ratings] = @ratings
    else
      if(params[:commit] == nil && params[:sorting] == nil)
        ratings = Movie.get_ratings.keys
        session[:ratings] = Movie.get_ratings
      else
        ratings = session[:ratings].keys
      end
    end
    @movies = Movie.order(@sorting).find_all_by_rating(ratings)
    @check = ratings
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
