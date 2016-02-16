class Search < ActiveRecord::Base

  def search_movies
    movies = Movie.all

    movies = movies.where("title LIKE ?", "%#{title}%") if title.present?
    movies = movies.where("director LIKE ?", "%#{director}%") if director.present?
    movies = movies.where("runtime_in_minutes >= ?", min_runtime) if min_runtime.present?
    movies = movies.where("runtime_in_minutes <= ?", max_runtime) if max_runtime.present?
    movies = movies.where("runtime_in_minutes #{runtime}") if runtime.present?

    return movies

  end

end