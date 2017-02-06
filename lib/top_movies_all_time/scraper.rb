class TopMoviesAllTime::Scraper

  def self.get_domestic_list
    Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/domestic.htm"))
  end

  def self.get_worldwide_list
    Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/world/"))
  end

  def self.get_adjusted_list
    Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/adjusted.htm"))
  end

  def self.adjusted_rankings
    adjusted_rankings = {}
    self.scrape_list(self.get_adjusted_list).each do |t|
       adjusted_rankings[t.css("td[2] a b").text] = t.css("td[1]").text
    end
    adjusted_rankings
  end

  def self.domestic_rankings
    domestic_rankings = {}
    self.scrape_list(self.get_domestic_list).each do |t|
       domestic_rankings[t.css("td[2] a b").text] = t.css("td[1]").text
    end
    domestic_rankings
  end

  def self.worldwide_rankings
    worldwide_rankings = {}
    self.scrape_list(self.get_worldwide_list).each do |t|
       worldwide_rankings[t.css("td[2] a b").text] = t.css("td[1]").text
    end
    worldwide_rankings
  end

  def self.worldwide_list
    self.worldwide_rankings.each do |k, v|
      unless k == ""
      puts "#{v}. #{k}"
      end
    end
  end

  def self.domestic_list
    self.domestic_rankings.each do |k, v|
      unless k == ""
      puts "#{v}. #{k}"
      end
    end
  end

  def self.adjusted_list
    self.adjusted_rankings.each do |k, v|
      unless k == ""
      puts "#{v}. #{k}"
      end
    end
  end

  def self.set_attributes(movie, url)
    doc = Nokogiri::HTML(open(url))
    #movie.release_date = doc.css()
    #movie.domestic_gross = doc.css()
    #movie.adjusted_gross = doc.css()
    #movie.worldwide_gross = doc.css()
    #movie.tickets_sold = doc.css()
  end

  def self.scrape_list(list)
    list.css("div#main div#body table table tr")
  end

  def self.make_movies
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
