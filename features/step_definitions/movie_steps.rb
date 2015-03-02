# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie[:title], :rating => movie[:rating], :release_date => movie[:release_date], :director => movie[:director])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  elem = page.html
  assert(elem.index(e1) < elem.index(e2), "incorrect behavior")
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating|
    #flunk uncheck
    if uncheck
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  movies = Movie.find(:all)
  if movies.size == 10
    movies.each do |movie|
      assert(page.body =~ /#{movie[:title]}/m, "#{movie[:title]} not match")
    end
  else
    return false
  end
end

Then /the director of "(.*)" should be "(.*)"/  do |title, name|
  @movie = Movie.find_by_title(title)
  assert (@movie.director == name, "direcor for #{@movie.title} not match")
end

# When /^(?:|I )press "([^"]*)"$/ do |button|
#   click_button(button)
# end

# When /^(?:|I )check "([^"]*)"$/ do |field|
#   check(field)
# end

# When /^(?:|I )uncheck "([^"]*)"$/ do |field|
#   uncheck(field)
# end