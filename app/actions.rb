helpers do
  def logged_in?
    !session[:user_id].nil?
  end

  def current_user
    User.find(session[:user_id]) if logged_in?
  end
end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

post '/users/create' do
  # grab information from form
  name     = params[:name]
  email    = params[:email]
  password = params[:password]

  # user information to create new user
  user = User.create({
    name:     name,
    email:    email,
    password: password
  })

  # log user into website
  session[:user_id] = user.id

  # redirect them to their profile page
  redirect '/profile'
end

get '/profile' do
  if logged_in?
    erb :profile
  else
    redirect "/"
  end
end

post "/sessions/new" do
  # get information from form
  email = params[:email]
  password = params[:password]

  # find user and verify password
  user = User.find_by(email: email)
  if user && user.password == password
    # log user in
    session[:user_id] = user.id

    # redirect to /profile
    redirect "/profile"
  else
    redirect "/login"
  end
end

get '/logout' do
  # clear the session
  session.clear

  # redirect to homepage
  redirect "/"
end
