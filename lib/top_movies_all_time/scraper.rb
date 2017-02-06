class TopMoviesAllTime::Scraper

  def get_domestic_list
    Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/domestic.htm"))
  end

  def get_worldwide_list
    Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/world/"))
  end

  def get_adjusted_list
    html = Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/adjusted.htm"))
    html
  end

  def scrape_list(list)
    list.css.("div#main div#body table table tr td[2]")
  end

  def make_movies
    movies = []
    self.scrape_list(get_adjusted_list).each do |t|
      movies << {
        :title => t.css("a b").text,
        :url => "http://www.boxofficemojo.com#{t.css("a").attribute("href").value}"
      }
    end
    movies
  end
  

end

binding.pry
