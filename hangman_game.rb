class Hangman

  def initialize
    @letters  = ('a'..'z').to_a

    @word = words.sample
    @lives = @word.first.size - 1
    @good_guess = []

    @word_teaser = ''

    @word.first.size.times do
      @word_teaser += '_ '
    end
  end

  def words
    [
      ["continente", "Existen 7 de estos"],
      ["princesa", "Usa vestido y corona"],
      ["arcoíris", "Tiene muchos colores en el cielo"],
      ["helado", "Es frío y dulce"],
      ["masha", "Es pequeña y traviesa"],
      ["peluche", "Es suave y se abraza"],
      ["papá", "Te quiere mucho"],
      ["mariposa", "Vuela y tiene alas coloridas"],
      ["castillo", "Donde viven las princesa peach"],
      ["flor", "Es bonita y huele bien"],
      ["globo", "Es redondo y vuela cuando lo inflas"],
    ]
  end

  def make_guess
    win_match if @word.first == @word_teaser.split().join()

    puts "Teclea una letra"
    guess = gets.chomp

    good_guess = @word.first.include? guess

    if good_guess
      @good_guess << guess
      
      print_treaser guess
      make_guess
    else
      @lives -= 1
      game_over if @lives == 0
        
      puts "Tienes #{@lives} vidas, Intenta de nuevo!"
      make_guess
    end
  end

  def win_match
    puts "Felicidades ganaste, eres muy inteligente"
    exit(false)
  end

  def game_over
    puts "Se acabo el Juego"
    exit(false)
  end

  def print_treaser last_guess = nil
    update_teaser(last_guess) unless last_guess.nil?

    puts @word_teaser
  end

  def update_teaser last_guess
    new_teaser = @word_teaser.split

    new_teaser.each_with_index do |letter, index|
      if letter == '_' && @word.first.split(//)[index] == last_guess
        new_teaser[index] = last_guess
      end 
    end

    @word_teaser = new_teaser.join(' ')
  end

  def begin
    puts "La palabra a adivinar tiene #{@word.first.size} letras"
    puts "El juego ha comenzado, tu pista es #{@word.last}"
    print_treaser
    make_guess
  end
  
end

game = Hangman.new
game.begin