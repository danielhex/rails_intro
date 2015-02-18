# class MoviesController < ApplicationController

#   def show
#     id = params[:id] # retrieve movie ID from URI route
#     @movie = Movie.find(id) # look up movie by unique ID
#     # will render app/views/movies/show.<extension> by default
#   end

#   def index

#     #********************************************************************

#     # if(params[:sorting] == nil && params[:ratings] == nil)
#     #   if(session[:sorting] != nil || session[:ratings] != nil)
#     #     redirect_to movies_path(:sorting =>session[:sorting], :ratings=>session[:ratings])
#     #   end
#     # end
    
#     # @sorting = params[:sorting]
#     # if params.has_key?(:sorting) 
#     #   @sorting = params[:sorting]
#     # end
#     # session[:sorting] = @sorting

#     # @all_ratings = Movie.get_ratings.keys
#     # @ratings = params[:ratings]
#     # if(@ratings != nil)
#     #   ratings = @ratings.keys
#     #   session[:ratings] = @ratings
#     # else
#     #   if(params[:commit] == nil && params[:sorting] == nil)
#     #     ratings = Movie.get_ratings.keys
#     #     session[:ratings] = Movie.get_ratings
#     #   else
#     #     ratings = session[:ratings].keys
#     #   end
#     # end
#     # @movies = Movie.order(@sorting).find_all_by_rating(ratings)
#     # @check = ratings
#   end

#   def new
#     # default: render 'new' template
#   end

#   def create
#     @movie = Movie.create!(params[:movie])
#     flash[:notice] = "#{@movie.title} was successfully created."
#     redirect_to movies_path
#   end

#   def edit
#     @movie = Movie.find params[:id]
#   end

#   def update
#     @movie = Movie.find params[:id]
#     @movie.update_attributes!(params[:movie])
#     flash[:notice] = "#{@movie.title} was successfully updated."
#     redirect_to movie_path(@movie)
#   end

#   def destroy
#     @movie = Movie.find(params[:id])
#     @movie.destroy
#     flash[:notice] = "Movie '#{@movie.title}' deleted."
#     redirect_to movies_path
#   end

# end

class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #part3  remember
    if(params[:sort] == nil && params[:ratings] == nil)
      if(session[:sort] != nil || session[:ratings] != nil)
        redirect_to movies_path(:sort=>session[:sort], :ratings=>session[:ratings])
      end
    end
    
    #part1  sorting
    @sort = params[:sort]
    if(@sort == 'title')
      @sort = :title
    elsif(@sort == 'release_date')
      @sort = :release_date
    end
    session[:sort] = @sort

    
    #part2  rating checkbox
    @all_ratings = Movie.all_ratings.keys
    @ratings = params[:ratings]
    if(@ratings != nil)
      ratings = @ratings.keys
      session[:ratings] = @ratings
    #if no current input ratings, but input sort, use last time input ratings
    else
      if(params['commit'] == nil && params['sort'] == nil)
        ratings = Movie.all_ratings.keys
        session[:ratings] = Movie.all_ratings
      else
        ratings = session[:ratings].keys
      end
    #if no current input ratings and input sort, ratings filter = all_ratings
#else
#ratings = Movie.all_ratings
#session[:ratings] = Movie.all_ratings
    end

    if(@sort != nil) 
      @movies = Movie.order(@sort).find_all_by_rating(ratings)
    else
      @movies = Movie.find_all_by_rating(ratings)
    end
    
    #indicate checked boxes
    @check  = ratings
  
#@movies = Movie.find_all_by_rating(ratings)

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
  
  def find_class(header)
    if(params[:sort] == header)
      return 'hilite'
    else
      return nil
    end
  end
  helper_method :find_class

end
