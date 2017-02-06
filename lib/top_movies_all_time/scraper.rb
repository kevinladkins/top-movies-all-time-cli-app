class TopMoviesAllTime::Scraper

  attr_reader = :domestic_list, :worldwide_list, :adjusted_list

  def initialize
    @domestic_list = Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/domestic.htm"))
    @worldwide_list = Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/world/"))
    @adjusted_list = Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/adjusted.htm"))
  end

  def get_domestic_list

  end

  def get_worldwide_list

  end

  def get_adjusted_list

  end

  def adjusted_rankings
    adjusted_rankings = {}
    self.scrape_list(@adjusted_list).each do |t|
       adjusted_rankings[t.css("td[2] a b").text] = t.css("td[1]").text
    end
    adjusted_rankings
  end

  def domestic_rankings
    domestic_rankings = {}
    self.scrape_list(@domestic_list).each do |t|
       domestic_rankings[t.css("td[2] a b").text] = t.css("td[1]").text
    end
    domestic_rankings
  end

  def worldwide_rankings
    worldwide_rankings = {}
    self.scrape_list(@worldwide_list).each do |t|
       worldwide_rankings[t.css("td[2] a b").text] = t.css("td[1]").text
    end
    worldwide_rankings
  end

  def scrape_list(list)
    list.css("div#main div#body table table tr")
  end

  def make_movies
    self.scrape_list(@adjusted_list).each do |t|
      TopMoviesAllTime::Movie.create_from_list(t)
    end
    self.scrape_list(@domestic_list).each do |t|
      TopMoviesAllTime::Movie.create_from_list(t)
    end
    self.scrape_list(@worldwide_list).each do |t|
      TopMoviesAllTime::Movie.create_from_list(t)
    end
  end


end

binding.pry
