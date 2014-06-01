Jialong::Um.controllers :base do
  before do
    #if  access_control.allowed?(current_account, '/um')
     login_required
     puts "login Requireed2"
   # end
 end
 
   get :index, :map => '/' do


     #session[:foo] = 'bar'
     puts settings
     render 'index',nil,:layout=>"application"
     # "hello!"
   end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  

end
