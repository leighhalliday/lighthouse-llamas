helpers do
  def logged_in?
    if session[:user_id]
      return true
    else
      return false
    end
  end

  def current_user
    if logged_in?
      return User.find(session[:user_id])
    else
      return nil
    end
  end
end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/login' do
  erb :login
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

get '/signup' do
  erb :signup
end

post '/users/create' do
  # grab information from form
  name = params[:name]
  email = params[:email]
  password = params[:password]

  # check to make sure user doesn't already exist
  user = User.find_by(email: email)
  if user
    redirect '/login'
  end

  # user information to create new user
  user = User.create({
    name: name,
    email: email,
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
    redirect "/login"
  end
end

get '/logout' do
  # clear the session
  session.clear

  # redirect to homepage
  redirect '/'
end

get '/llamas' do
  scope = Llama

  if params[:search]
    scope = scope.where(name: params[:search])
  end

  @llamas = scope.where("user_id is not null").order("age desc").all
  erb :list_llamas
end

get '/llamas/new' do
  erb :new_llama
end

post '/llamas/create' do
  if !logged_in?
    return redirect "/login"
  end

  llama = current_user.llamas.create({
    name: params[:name],
    age: params[:age],
    quality: params[:quality],
    gender: params[:gender]
  })

  redirect "/llamas/#{llama.id}"
end

get '/llamas/:id' do
  @llama = Llama.find(params[:id])
  erb :show_llama
end

get '/llamas/:id/edit' do
  @llama = Llama.find(params[:id])
  erb :edit_llama
end

post '/llamas/:id/update' do
  llama = Llama.find(params[:id])

  llama.update_attributes({
    name: params[:name],
    age: params[:age],
    quality: params[:quality],
    gender: params[:gender]
  })

  redirect "/llamas/#{llama.id}"
end

get '/llamas/:llama_id/garments/new' do
  @llama = Llama.find(params[:llama_id])
  erb :new_garment
end

post '/llamas/:llama_id/garments/create' do
  @llama = Llama.find(params[:llama_id])

  @llama.garments.create({
    name: params[:name],
    description: params[:description]
  })

  redirect "/llamas/#{@llama.id}"
end