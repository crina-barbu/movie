class Movie < ActiveRecord::Base
  def Movie.get_ratings 
    @all_ratings = Array.new
    @movies = Movie.find(:all, :order => 'rating')
    @ok = true
    @k = 0
    for i in 0..@movies.length-1 do
      for j in 0..@all_ratings.length-1 do
        if @all_ratings[j] == @movies[i].rating
          @ok = false
        end
      end
      if @ok == true
         @all_ratings[@k] = @movies[i].rating
         @k += 1
      end
      @ok = true
    end
    return @all_ratings
  end
end
