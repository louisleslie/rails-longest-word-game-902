
class GamesController < ApplicationController
    def new
        @letters = ('a'..'z').to_a.sample(10)
    end

    def score
        @guess = params[:guess]
        @letters = params[:letters].split
        raise
        if guess_in_letters(@guess, @letters)
            url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
            request = URI.open(url).read
            api_request = JSON.parse(request)
            if api_request["found"]
                @message = "Congratulations, #{@guess} is a valid word"
            else 
                @message = "Sorry #{@guess} is not a valid word"
            end
        else
            @message = "Sorry, #{@guess} includes letters that aren't in the grid"
        end
        
    end

    private

    def guess_in_letters(guess, letters)
        guess.chars.all? do |guess_letter|
            if letters.include?(guess_letter)
                letters.pop(letters.index(guess_letter))
                true
            else
                false
            end
        end

    end
end
