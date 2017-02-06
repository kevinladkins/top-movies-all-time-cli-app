require_relative 'movie.rb'
require_relative 'scraper.rb'
require_relative '../top-movies-all-time.rb'

class TopMoviesAllTime::CLI

  def call
    start
  end

  def start
    TopMoviesAllTime::Scraper.make_movies
    puts "--------------TOP MOVIES OF ALL TIME--------------"
    puts " "
    puts "Welcome!"
    puts " "
    main_menu
  end

  def main_menu
    puts "Which list would you like to see?"
    puts " "
    puts "1. US Domestic Box Office"
    puts "2. US Domestic Box Office - Adjusted for Inflation"
    puts "3. Worldwide Box Office"
    input = gets.chomp
    choose_list(input) unless input == "exit"
  end


  def choose_list(input)
    if input == "1" || input == "US Domestic Box Office"
      print_domestic_list
    elsif input == "2" || input == "US Domestic Box Office - Adjusted for Inflation"
      print_adjusted_list
    elsif input == "3" || input == "Worldwide Box Office"
      print_worldwide_list
    end
  puts "To see more information, enter a movie by ranking or title"
  puts "To choose another list, enter list. To exit, enter exit."
    input = gets.chomp
    unless input == "exit"
      if input == "list"
        main_menu
      else
      display_movie(input)
      end
    end
  end


  def display_movie(input)
    movie = find_movie(input)
    puts "--------------#{movie.title}--------------"
    puts " "
    puts "RELEASE DATE: #{movie.release_date}"
    puts " "
    puts "US Domestic Gross: #{movie.domestic_gross}"
    puts "US Domestic Gross (Inflation-Adjusted): #{movie.adjusted_gross}"
    puts "Worldwide Gross: #{movie.worldwide_gross}"
    puts "Total Tickets Sold: #{movie.tickets_sold}"
    puts ""
    puts "To view another movie, enter ranking or title."
    puts "To view another list, enter lists."
    input = gets.chomp
    if input == "lists"
      main main_menu
    else
      display_movie(input)
    end
  end

  def find_movie(input)
    if input.to_i == 0
      movie = TopMoviesAllTime::Movie.find_by_title(input)
      movie.populate_attributes
      movie
    elsif input.to_i > 0 && input.to_i < 101
      movie = TopMoviesAllTime::Movie.find_by_title(TopMoviesAllTime::Scraper.domestic_rankings[input])
      movie.populate_attributes
      movie
    else
      puts "Please enter a valid title or ranking"
    end
  end


  def print_domestic_list
    ranking = TopMoviesAllTime::Scraper.domestic_rankings
    ranking.each do |k, v|
      unless k == ""
      puts "#{k}. #{v}"
      end
    end
  end

  def print_adjusted_list
    ranking = TopMoviesAllTime::Scraper.adjusted_rankings
    ranking.each do |k, v|
      unless k == ""
      puts "#{k}. #{v}"
      end
    end
  end

  def print_worldwide_list
    ranking = TopMoviesAllTime::Scraper.worldwide_rankings
    ranking.each do |k, v|
      unless k == ""
      puts "#{k}. #{v}"
      end
    end
  end



end
