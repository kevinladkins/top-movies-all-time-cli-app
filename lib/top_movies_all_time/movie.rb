class TopMoviesAllTime::Movie

  attr_accessor :title, :url, :domestic_gross, :adjusted_gross, :worldwide_gross, :tickets_sold, :release_date

  @@all = []

  def initialize(title, url)
    @title = title
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def populate_attributes
    TopMoviesAllTime::Scraper.set_attributes(self, self.url)
  end

  def self.find_by_title(title)
   self.all.detect {|movie| movie.title == title}
  end

end
