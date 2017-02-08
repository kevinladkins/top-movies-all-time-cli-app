class TopMoviesAllTime::Scraper

  def self.get_lists
    lists = {}
    lists[:domestic] = Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/domestic.htm"))
    lists[:adjusted] = Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/adjusted.htm"))
    lists[:worldwide] = Nokogiri::HTML(open("http://www.boxofficemojo.com/alltime/world/"))
    return lists
  end

  def self.adjusted_rankings
    adjusted_rankings = {}
    scrape_list(get_lists[:adjusted]).each {|t| adjusted_rankings[t.css("td[1]").text] = t.css("td[2] a b").text}
    adjusted_rankings.shift
    adjusted_rankings
  end

  def self.domestic_rankings
    domestic_rankings = {}
    scrape_list(get_lists[:domestic]).each {|t| domestic_rankings[t.css("td[1]").text] = t.css("td[2] a b").text}
    5.times {domestic_rankings.shift}
    domestic_rankings
  end

  def self.worldwide_rankings
    worldwide_rankings = {}
    scrape_list(get_lists[:worldwide]).each {|t| worldwide_rankings[t.css("td[1]").text] = t.css("td[2] a b").text}
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
    scrape_list(get_lists[:adjusted]).each {|t| find_or_create_movie(t)}
    scrape_list(get_lists[:domestic]).each {|t| find_or_create_movie(t)}
    scrape_list(get_lists[:worldwide]).each {|t| find_or_create_movie(t)}
  end

  def self.find_or_create_movie(list)
   unless TopMoviesAllTime::Movie.find_by_title(list.css("td[2] a b").text) != nil
     TopMoviesAllTime::Movie.new(list.css("td[2] a b").text,
       self.url_normalizer(list.css("td[2] a").attribute("href").value))
    end
  end

  def self.url_normalizer(url)
    if url.scan(/page=releases/) != []
      "http://www.boxofficemojo.com#{url.split("releases").join("main")}"
    else
      "http://www.boxofficemojo.com#{url}"
    end
  end


binding.pry

end
