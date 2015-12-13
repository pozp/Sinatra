require 'sinatra'
require 'data_mapper'
require 'sqlite3'
require 'dm-sqlite-adapter'


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


get '/about' do   #kolejna strona
    @title = "About"
    erb :about
end
    


