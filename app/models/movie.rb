# class Movie < ActiveRecord::Base
#   attr_accessible :title, :rating, :description, :release_date
#   def self.all_ratings
#   	result = {}
#   	self.select(:rating).uniq.each do |movie|
#   		result[movie.rating] = 1
#   	end
#   	return result
#   end
# end

class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  def self.all_ratings
    {'G'=>'1', 'PG'=>'1', 'PG-13'=>'1', 'R'=>'1'}
  end
end
