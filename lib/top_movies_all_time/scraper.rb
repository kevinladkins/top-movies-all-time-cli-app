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
    scrape_list(get_adjusted_list).each {|t| adjusted_rankings[t.css("td[1]").text] = t.css("td[2] a b").text}
    adjusted_rankings.shift
    adjusted_rankings
  end

  def self.domestic_rankings
    domestic_rankings = {}
    scrape_list(self.get_domestic_list).each {|t| domestic_rankings[t.css("td[1]").text] = t.css("td[2] a b").text}
    5.times {domestic_rankings.shift}
    domestic_rankings
  end

  def self.worldwide_rankings
    worldwide_rankings = {}
    scrape_list(get_worldwide_list).each {|t| worldwide_rankings[t.css("td[1]").text] = t.css("td[2] a b").text}
    worldwide_rankings.shift
    worldwide_rankings
  end

  def self.set_attributes(movie, url)
    doc = Nokogiri::HTML(open(url))
    adjusted_doc = Nokogiri::HTML(open(url + "&adjust_yr=2017&p=.htm"))
    ticket_doc = Nokogiri::HTML(open(url + "&adjust_yr=1&p=.htm"))
    movie.release_date = doc.xpath('//td[contains(text(), "Release Date")]').css("b").text
    movie.domestic_gross = doc.xpath('//font[contains(text(), "Domestic Total Gross")]').css("b").text
    movie.worldwide_gross = doc.css("div.mp_box_content table tr[4] td[2] b").text.split("Rank").first
    movie.adjusted_gross = adjusted_doc.xpath('//font[contains(text(), "Adj.")]').css("b").text
    movie.tickets_sold = ticket_doc.xpath('//font[contains(text(), "Est. Tickets")]').css("b").text
  end

  def self.scrape_list(list)
    list.css("div#main div#body table table tr")
  end

  def self.make_movies
    scrape_list(get_adjusted_list).each {|t|TopMoviesAllTime::Movie.create_from_list(t)}
    scrape_list(get_domestic_list).each {|t| TopMoviesAllTime::Movie.create_from_list(t)}
    scrape_list(get_worldwide_list).each {|t| TopMoviesAllTime::Movie.create_from_list(t)}
  end

end
