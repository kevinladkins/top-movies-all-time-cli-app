class TopMoviesAllTime::CLI

  def call
    start
  end

  def start
    puts "--------------TOP MOVIES OF ALL TIME--------------"
    puts "Welcome! Which list would you like to see?"
    puts " "
    puts "1. US Domestic Box Office"
    puts "2. US Domestic Box Office - Adjusted for Inflation"
    puts "3. Worldwide Box Office"
    input = gets.chomp
    while input != "exit"
      if input == "1" || input == "US Domestic Box Office"
        print_domestic_list
      elsif input == "2" || input == "US Domestic Box Office - Adjusted for Inflation"
        print_adjusted_list
      elsif input == "3" || input == "Worldwide Box Office"
        print_worldwide_list
      else
        start
      end
    end
    puts "Thanks for stopping by!"
  end

  def print_domestic_list
    puts TopMoviesAllTime::Scraper.domestic_rankings
  end

end
