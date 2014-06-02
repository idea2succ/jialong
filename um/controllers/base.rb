Jialong::Um.controllers :base do
  before do
     login_required
 end
 
   get :index, :map => '/' do
     #session[:foo] = 'bar'
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
