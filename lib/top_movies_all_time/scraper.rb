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

  def adjusted_rankings
    adjusted_rankings = {}
    self.scrape_list(self.get_adjusted_list).each do |t|
       adjusted_rankings[t.css("td[2] a b").text] = t.css("td[1]").text
    end
    adjusted_rankings
  end


  def scrape_list(list)
    list.css("div#main div#body table table tr")
  end

  def make_movies
    self.scrape_list(self.get_adjusted_list).each do |t|
      TopMoviesAllTime::Movie.create_from_list(t)
    end
    self.scrape_list(self.get_domestic_list).each do |t|
      TopMoviesAllTime::Movie.create_from_list(t)
    end
    self.scrape_list(self.get_worldwide_list).each do |t|
      TopMoviesAllTime::Movie.create_from_list(t)
    end
  end


end

binding.pry
