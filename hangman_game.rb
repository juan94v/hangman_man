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

    @COLOR_GREEN = "\e[32m"
    @COLOR_RED = "\e[31m"
    @COLOR_PINK = "\e[95m"
    @COLOR_PURPLE = "\e[35m"
    @COLOR_ORANGE = "\e[33m"
    @COLOR_RESET = "\e[0m"
  end

  def words
    [
      ["continente", "Existen 7 de estos"],
      ["princesa", "Usa vestido y corona"],
      ["arcoíris", "Tiene muchos colores en el cielo"],
      ["helado", "Es frío y dulce"],
      ["peluche", "Es suave y se abraza"],
      ["papá", "Te quiere mucho"],
      ["mariposa", "Vuela y tiene alas coloridas"],
      ["castillo", "Donde vive las princesa peach"],
      ["flor", "Es bonita y huele bien"],
      ["globo", "Es redondo y vuela cuando lo inflas"],
      ["masha", "Niña traviesa y curiosa"],
      ["oso", "Amigo de Masha, grande y peludo"],
      ["elsa", "Reina de hielo con poderes mágicos"],
      ["ana", "Hermana de Elsa, valiente y amorosa"],
      ["bella", "Joven inteligente y valiente"],
      ["Arnold", "Tiene cabeza de balón"],
      ["zenon", "Personaje divertido de la granja"],
      ["pepe", "Amigo de Zenon, gracioso y alegre"]
    ]
  end

  def make_guess
    end_game(:win) if @word.first == @word_teaser.split().join()

    puts "#{@COLOR_PINK}Teclea una letra#{@COLOR_RESET}"
    guess = gets.chomp

    good_guess = @word.first.include? guess

    if good_guess
      @good_guess << guess
      
      system("clear")
      print_life
      print "#{@COLOR_GREEN}Adivinaste!#{@COLOR_RESET}"
      puts "\n"
      system('say "Adivinaste"')

      info_message
      print_treaser guess
      make_guess
    else
      @lives -= 1
      end_game(:lose) if @lives == 0
        
      system("clear")
      print_life
      puts "#{@COLOR_PURPLE}Tienes #{@lives} vidas, Intenta de nuevo!#{@COLOR_RESET}"
      system('say "Intenta de nuevo Valeria!"')

      info_message
      print_treaser guess
      make_guess
    end
  end

  def end_game result
    message = {
      win: [@COLOR_GREEN, "Felicidades ganaste, eres muy inteligente"],
      lose: [@COLOR_RED,"Se acabo el Juego"]
    }

    puts "#{message[result].first}#{message[result].last}"
    system('say "Ganaste, eres muy inteligente"') if result == :win
    system('say "Fin del juego"')
    exit(false)
  end

  def print_treaser last_guess = nil
    update_teaser(last_guess) unless last_guess.nil?

    puts @word_teaser
    puts "\n"
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
    print_life
    info_message
    print_treaser
    make_guess
  end

  def info_message
    puts "#{@COLOR_ORANGE}La palabra a adivinar tiene #{@word.first.size} letras"
    puts "tu pista es #{@word.last}#{@COLOR_RESET}"
  end

  def print_life
    heart = "#{@COLOR_RED}\u{2764}#{@COLOR_RESET} "
    hearts = heart * @lives
    puts hearts
  end
  
end

game = Hangman.new
game.begin