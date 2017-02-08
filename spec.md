# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application  

  bin/top-movies-all-time calls TopMoviesAllTime::CLI, which starts a user interface that prompts for a selection of one of three options. Based on input, ::CLI collaborates with TopMoviesAllTime::Scraper and TopMoviesAllTime::Movie to generate and display requested data. User is then prompted for additional input, and ::CLI displays requested data in collaboration with ::Scraper and ::Movie.


- [x] Pull data from an external source

  Upon receiving call from ::CLI or ::Movies, ::Scraper scrapes data from one of several pages at http://www.boxofficemojo.com/, depending upon request.


- [x] Implement both list and detail views

  Via ::CLI, users can select any film from the three primary lists (by name or ranking) to see further information. Once such a request is made, ::CLI locates the ::Movie object associated with the user's selection via #find_movie and instructs the object to populate its attributes for display. The ::Movie object, in turn, calls ::Scraper via #populate_attributes, which prompts ::Scraper to collect additional data from the movie's page on  http://www.boxofficemojo.com/. Detailed data on the selected movie is then displayed to the user via ::CLI.
