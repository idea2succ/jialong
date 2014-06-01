Jialong::Um.controllers :users do


  get :new do
    @title = t("users.new_user")
    @user = User.new
    render 'users/new'
  end

  post :create do
    confirmed_pwd=params[:user][:password_confirmation]
    #params[:user].delete("password_confirmation")    
    @user = User.new(params[:user])
    if  params[:user][:password] != confirmed_pwd
        logger.info "confirm password different!}"
        flash.now[:error] = pat(:create_error, :model => 'user')
        @user.errors.add(:password, 'must confirm password')
        render 'users/new'
    else
   # @user.crypted_password=::BCrypt::Password.create(params[:user][:crypted_password])
    if (@user.save rescue false)
      @title = pat(:create_title, :model => "user #{@user.id}")
      flash[:success] = pat(:create_success, :model => 'User')
      params[:save_and_continue] ? redirect(url(:users, :index)) : redirect(url(:users, :edit, :id => @user.id))
    else
      @title = pat(:create_title, :model => 'user')
      flash.now[:error] = pat(:create_error, :model => 'user')
      render 'users/new'
    end
  end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "user #{params[:id]}")
    @user = User[params[:id]]
    if @user
      render 'users/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'user', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "user #{params[:id]}")
    @user = User[params[:id]]
    if @user
      if @user.modified! && @user.update(params[:user])
        flash[:success] = pat(:update_success, :model => 'User', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:users, :index)) :
          redirect(url(:users, :edit, :id => @user.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'user')
        render 'users/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'user', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Users"
    user = User[params[:id]]
    if user
      if user.destroy
        flash[:success] = pat(:delete_success, :model => 'User', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'user')
      end
      redirect url(:users, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'user', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Users"
    unless params[:user_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'user')
      redirect(url(:users, :index))
    end
    ids = params[:user_ids].split(',').map(&:strip)
    users = User.where(:id => ids)
    
    if users.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Users', :ids => "#{ids.to_sentence}")
    end
    redirect url(:users, :index)
  end
end
