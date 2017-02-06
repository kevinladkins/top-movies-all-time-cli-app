class TopMoviesAllTime::Movie
  attr_accessor :title, :url, :rank_adjusted, :rank_domestic, :rank_worldwide, :domestic_gross, :adjusted_gross, :worldwide_gross, :tickets_sold, :release_date

  @@all = []

  def initialize(title, url)
    @title = title
    @url = url
    @@all << self
    #self.set_rankings
  end

  def self.all
    @@all
  end


  def self.create_from_list(list)
    if self.find_by_title(list.css("td[2] a b").text)
      self.find_by_title(list.css("td[2] a b").text)
    else
      self.new(
       list.css("td[2] a b").text,
       self.url_normalizer(list.css("td[2] a").attribute("href").value)
      )
    end
  end

  def self.find_by_title(title)
   self.all.detect {|movie| movie.title == title}
  end

  def set_rankings
    if TopMoviesAllTime::Scraper.adjusted_rankings.include? (self.title)
        self.rank_adjusted = TopMoviesAllTime::Scraper.adjusted_rankings[self.title]
    end
    if TopMoviesAllTime::Scraper.domestic_rankings.include? (self.title)
      self.rank_domestic = TopMoviesAllTime::Scraper.domestic_rankings[self.title]
    end
    if TopMoviesAllTime::Scraper.worldwide_rankings.include? (self.title)
      self.rank_worldwide = TopMoviesAllTime::Scraper.worldwide_rankings[self.title]
    end
  end


  def self.url_normalizer(url)
    if url.scan(/page=releases/) != []
      "http://www.boxofficemojo.com#{url.split("releases").join("main")}"
    else
      "http://www.boxofficemojo.com#{url}"
    end
  end

end
