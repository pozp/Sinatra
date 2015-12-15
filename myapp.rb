require 'sinatra'
require 'data_mapper'



DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/myapp.db")

class Note
    include DataMapper::Resource
    property :id, Serial
    property :content, Text, :required => true
    property :complete, Boolean, :required => true, :default => false
    property :created_at, DateTime
    property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
    @title = "MyFirst App :)"  #zmienna instancji, czyli nalezaca do danego obiektu tu pełniaca role templatki
    @notes = Note.all :order => :id.desc
    erb :index  #symbol, czyli ":foo" mający jedna niezmienna wartosc, w tym przypadku przypisany do indexu, bo to kuzwa index nigggga
end

post '/' do
    n = Note.new
    n.content = params[:content]
    n.created_at = Time.now
    n.updated_at = Time.now
    n.save
    redirect '/'
end


get '/about' do   #HTTP tutaj metoda "get", czyli pobranie tresci z /about
    @title = "About"
    erb :about
end
    
get '/:id' do
    @note = Note.get params[:id]
    @title = "Edit note: #{params [:id]}"
    erb :edit
end

put '/:id' do
    n = Note.get params [:id]
    n.content = params [:content]
    n.complete = params [:complete] ? 1 : 0
    n.updated_at = Time.now
    n.save
    redirect '/'
end


