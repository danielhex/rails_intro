class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  def self.all_ratings
  	result = {}
  	self.select(:rating).uniq.each do |movie|
  		result[movie.rating] = 1
  	end
  	return result
  end
end
