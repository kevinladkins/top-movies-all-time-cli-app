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

  def scrape_lists(list)
    list.css.("div#main div#body table table tr td[2]")
  end

end
