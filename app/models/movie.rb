class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  def self.get_ratings
  	result = {'G'=>'1', 'PG'=>'1', 'PG-13'=>'1', 'R'=>'1'}
  	# self.select(:rating).uniq.each do |movie|
  	# 	result[movie.rating] = '1'
  	# end
  	return result
  end
end
