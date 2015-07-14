# Homepage (Root path)
get '/' do
  erb :index
end

get '/login' do
  erb :login
end

post "/sessions/new" do
  # check if email and password are correct
  # if correct, log user in & redirect to /profile
  # else, re-display login form with error message
  redirect "/profile"
end