require 'sinatra'

get '/' do
    @title = "List full of shit"  #zmienna instancji, czyli nalezaca do danego obiektu tu pełniaca role templatki
    erb :index #symbol, czyli ":foo" mający jedna niezmienna wartosc, w tym przypadku przypisany do do indexu, bo to kuzwa index nigggga
end

post '/vote' do                              #kolejna strona
   @title = "Another site mothafuka"
   @vote = params['vote']
   erb :vote
end

get '/results' do 
    @votes ={}
    erb :results
end
    

Choices = {
    "LEN" => "Learn",
    "COK" => "Cook",
    "SMI" => "Smile",
}
   

