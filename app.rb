require './classes/book'
require './modules/book_module'
require './classes/game'
require './modules/game_module'
require './classes/musicalbum'
require './modules/musicalbum_module'
require './modules/genre_module'
require './modules/author_module'
require './modules/label_module'

class App
  include BooksData
  include GameModule
  include MusicAlbumData
  include GenreData
  include AuthorModule
  include LabelsData

  def initialize
    @books = load_books
    @games = load_game
    @albums = load_album
    @genres = load_genre
    @authors = load_author
    @labels = load_labels

    @options = [
      'List all books',
      'List all music albums',
      'List all games',
      'List all genres',
      'List all labels',
      'List all authors',
      'Add a book',
      'Add a music album',
      'Add a game',
      'Exit'
    ]
  end

  def run
    puts '----------------------'
    puts 'Welcome to the app!'

    loop do
      puts '----------------------'
      puts 'Please choose an option: [1-10]'
      @options.each_with_index do |option, index|
        puts "#{index + 1}. #{option}"
      end
      user_input
    end
  end

  def user_input
    user_option = gets.chomp.to_i
    operation(user_option)
  end

  def operation(user_option)
    case user_option
    when 1 then list_all_books
    when 2 then list_all_music_albums
    when 3 then list_all_games
    when 4 then list_all_genres
    when 5 then list_all_labels
    when 6 then list_all_authors
    else operation_two(user_option)
    end
  end

  def operation_two(user_option)
    case user_option
    when 7 then add_book
    when 8 then add_music_album
    when 9 then add_game
    when 10 then exit_app
    else
      puts 'Invalid option'
    end
  end

  def list_all_books
    if @books.empty?
      puts 'There are no books in the library'
      return
    end
    @books.each_with_index do |book, index|
      puts "#{index + 1}-Name: #{book.name}
      \rPublisher: #{book.publisher}
      \rCover state: #{book.cover_state}
      \rPublish date: #{book.publish_date}
      \n"
    end
  end

  def list_all_music_albums
    if @albums.empty?
      puts 'There are no albums in the List'
      nil
    else
      @albums.each do |album|
        puts "Publish date: #{album.publish_date}"
        puts "On Spotify: #{album.on_spotify}"
      end
    end
  end

  def list_all_games
    if @games.empty?
      puts 'There are no games in the List'
      nil
    else
      @games.each do |game|
        puts "Publish date: #{game.publish_date}"
        puts "Multiplayer: #{game.multiplayer}"
        puts "Last played at: #{game.last_played_at}"
      end
    end
  end

  def list_all_genres
    if @genres.empty?
      puts 'There are no genres in the library'
      return
    end
    @genres.each do |genre|
      puts "ID: #{genre.id}"
      puts "name: #{genre.name}"
    end
  end

  def list_all_labels
    @labels.each do |label|
      puts "ID: #{label.id}"
      puts "Title: #{label.title}"
      puts "Color: #{label.color}"
    end
  end

  def list_all_authors
    if @authors.empty?
      puts 'There are no authors in the library'
      return
    end
    @authors.each do |author|
      puts "ID: #{author.id}"
      puts "First name: #{author.first_name}"
      puts "Last name: #{author.last_name}"
    end
  end

  def add_book
    puts 'Please enter the name of the book:'
    name = gets.chomp
    puts 'Please enter the publisher of the book:'
    publisher = gets.chomp
    puts 'Please enter the cover state of the book: good/bad'
    cover_state = gets.chomp
    if cover_state != 'good' && cover_state != 'bad'
      puts 'Invalid cover state'
      return
    end
    puts 'Please enter the publish date of the book: YYYY-MM-DD'
    date = gets.chomp
    puts date
    book = Book.new(name, publisher, cover_state, date)
    @books << book
    create_label('book', book)
    create_author(book)
    save_books
    puts 'Successfully added book!'
  end

  def add_music_album
    puts 'Please enter the publish date of the album: YYYY-MM-DD'
    publish_date = gets.chomp
    puts 'Please enter the on spotify option of the album: true/false'
    on_spotify = gets.chomp
    if on_spotify != 'true' && on_spotify != 'false'
      puts 'Invalid on_spotify option'
      return
    end
    album = MusicAlbum.new(publish_date, on_spotify)
    @albums << album
    create_genre(album)
    create_label('music', album)
    create_author(album)
    save_album
    puts 'Successfully added album!'
  end

  def add_game
    puts 'Please enter the publish date of the game: YYYY-MM-DD'
    publish_date = gets.chomp
    puts 'Please enter the multiplayer option of the game: true/false'
    multiplayer = gets.chomp
    if multiplayer != 'true' && multiplayer != 'false'
      puts 'Invalid multiplayer option'
      return
    end
    puts 'Please enter the last played date of the game: YYYY-MM-DD'
    last_played_at = gets.chomp
    game = Game.new(publish_date, multiplayer, last_played_at)
    @games << game
    create_author(game)
    save_game
    puts 'Successfully added game!'
  end

  def exit_app
    puts 'Thank you for using the app!'
    exit
  end
end
