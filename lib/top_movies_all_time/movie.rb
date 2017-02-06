class TopMoviesAllTime::Movie
  attr_accessor :title, :url, :rank_adjusted, :rank_domestic, :rank_worldwide, :domestic_gross, :adjusted_gross, :worldwide_gross, :tickets_sold, :release_date

  @@all = []

  def initialize(title, url)
    @title = title
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end


  def self.create_from_list(list)
    if self.find_by_name(title)

    else
      self.new
    end
  end

  def self.find_by_title(title)
   self.all.detect {|movie| movie.title == title}
  end

end
