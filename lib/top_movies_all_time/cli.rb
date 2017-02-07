require_relative 'movie.rb'
require_relative 'scraper.rb'
require_relative '../top-movies-all-time.rb'
require 'colorize'

class TopMoviesAllTime::CLI

  @mode = " "

  def call
    start
  end

  def start
    TopMoviesAllTime::Scraper.make_movies
    puts " "
    puts " "
    puts "--------------TOP MOVIES OF ALL TIME--------------".colorize(:red)
    puts "Welcome!"
    main_menu
  end

  def main_menu
      puts " "
      puts "Which list would you like to see?"
      puts " "
      puts "1." + "US Domestic Box Office".colorize(:light_blue)
      puts "2." + "US Domestic Box Office - Adjusted for Inflation".colorize(:light_blue)
      puts "3." + "Worldwide Box Office".colorize(:light_blue)
      input = gets.chomp
      if input != "exit"
        choose_list(input)
      end
      puts "Thanks for dropping by!"
  end


  def choose_list(input)
    if input == "1" || input == "US Domestic Box Office"
      @mode = TopMoviesAllTime::Scraper.domestic_rankings
      print_list
    elsif input == "2" || input == "US Domestic Box Office - Adjusted for Inflation"
      @mode = TopMoviesAllTime::Scraper.adjusted_rankings
      print_list
    elsif input == "3" || input == "Worldwide Box Office"
      @mode = TopMoviesAllTime::Scraper.worldwide_rankings
      print_list
    end
  puts " "
  puts "To see more information, enter a movie by " + "ranking ".colorize(:light_blue) + "or " + "title.".colorize(:light_blue)
  puts "To choose another list, enter " + "lists".colorize(:light_blue) + ". To exit, enter" + " exit.".colorize(:light_blue)
    input = gets.chomp
    unless input == "exit"
      if input == "lists"
        main_menu
      else
      display_movie(input)
      end
    end
  end


  def display_movie(input)
    movie = find_movie(input)
    puts "--------------".colorize(:red) + "#{movie.title}" + "--------------".colorize(:red)
    puts " "
    puts "RELEASE DATE: " + "#{movie.release_date}".colorize(:light_blue)
    puts " "
    puts "US Domestic Gross: " + "#{movie.domestic_gross}".colorize(:light_blue)
    puts "US Domestic Gross (Inflation-Adjusted): " + "#{movie.adjusted_gross}".colorize(:light_blue)
    puts "Worldwide Gross: " + "#{movie.worldwide_gross}".colorize(:light_blue)
    puts "Total Tickets Sold: " + "#{movie.tickets_sold}".colorize(:light_blue)
    puts ""
    puts "To view another movie, enter " + "ranking ".colorize(:light_blue) + "or " + "title.".colorize(:light_blue)
    puts "To view another list, enter " + "lists.".colorize(:light_blue)
    input = gets.chomp
    if input == "lists"
      main_menu
    else
      display_movie(input)
    end
  end

  def find_movie(input)
    if input.to_i == 0
      if TopMoviesAllTime::Movie.find_by_title(input) == nil
        puts "Please enter a valid title or ranking, or " + "lists".colorize(:light_blue) + " to return to lists."
        input = gets.chomp
        input == "lists" ? main_menu : find_movie(input)
      else
        movie = TopMoviesAllTime::Movie.find_by_title(input)
        movie.populate_attributes
        movie
      end
    elsif input.to_i > 0
      if TopMoviesAllTime::Movie.find_by_title(@mode[input]) == nil
        puts "Please enter a valid title or ranking, or " + "lists".colorize(:light_blue) + " to return to lists."
        input = gets.chomp
        input == "lists" ? main_menu : find_movie(input)
      else
        movie = TopMoviesAllTime::Movie.find_by_title(@mode[input])
        movie.populate_attributes
        movie
      end
    end
  end


  def print_list
    @mode.each do |k, v|
      unless k == ""
      puts "#{k}. ".colorize(:light_blue) + "#{v}"
      end
    end
  end

end
