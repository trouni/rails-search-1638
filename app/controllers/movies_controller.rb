class MoviesController < ApplicationController
  def index
    @movies = 
      if params[:q].present?
        sql_query = <<~SQL
        title @@ :q OR
        synopsis @@ :q OR
        directors.first_name @@ :q OR
        directors.last_name @@ :q
        SQL
        # @@ is called the full text search operator
        Movie.joins(:director).where(sql_query, q: "%#{params[:q]}%")
      else
        Movie.all
      end
  end
end
