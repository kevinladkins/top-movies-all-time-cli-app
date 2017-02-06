class TopMoviesAllTime::Movie
  attr_accessor :title, :url, :rank_adjusted, :rank_domestic, :rank_worldwide, :domestic_gross, :adjusted_gross, :worldwide_gross, :tickets_sold, :release_date

  @@all = []

  def initialize(title, url)
    @title = title
    @url = url
  end

end
