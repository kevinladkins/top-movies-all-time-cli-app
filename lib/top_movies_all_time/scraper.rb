class TopMoviesAllTime::Scraper

  def get_domestic_list
    Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/domestic.htm"))
  end

  def get_worldwide_list
    Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/world/"))
  end

  def get_adjusted_list
    Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/adjusted.htm"))
  end


  def scrape_list(list)
    list.css("div#main div#body table table tr")
  end

  def make_movies
    movies = []
    self.scrape_list(self.get_adjusted_list).each do |t|
      Movie.create_from_list(t)
    end
    movies
  end


end

binding.pry
