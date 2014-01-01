class UserController < ApplicationController
	def home
		
	end

	def register
		@user = User.new
	end

	#for registration
	def post_register
		#@user = User.new(user_params)
		@user = User.create(user_params) 
		if @user.valid?
			@user.save
			    respond_to do |format|
			      if @user.save
			        # Tell the UserMailer to send a welcome Email after save
			        UserMailer.welcome_email(@user).deliver
			 
			        format.html { redirect_to(:action=>'home', notice: 'User was successfully created.') }
			        format.xml { render xml: @user, status: :created, location: @user }
			      else
			        format.html { render action: 'register' }
			        format.json { render xml: @user.errors, status: :unprocessable_entity }
			      end
			  	end
			#redirect_to :controller => 'user', :action => 'home'
		else
			flash[:notice] = @user.errors.full_messages
			redirect_to :controller => 'pages', :action => 'error'
		end
	end

	def login
		if  session["user_id"] != nil
			@user = User.find(session["user_id"])
			redirect_to(:controller => :user, :action => :profile)#, #:id => @user.id)
		end
	end

	def post_login
		@user = User.find_by_email(params[:login_name])
		if @user != nil
			if @user.password_valid?(params[:password])
				session["user_id"] = @user.id
		  		redirect_to(:controller => :user, :action => :profile, :id => @user.id)
			else
				flash[:notice] = "Your password is incorrect. Please try again with the valid password"
		  		redirect_to :action => :login
			end 
		else
		  flash[:notice] = "The username \'#{params[:login_name]}\' doesn't exist. Please try again with a valid username"
		  redirect_to :controller => 'user', :action => 'error'# redirect_to :controller => 'gasf', :action => 'login'
		end
	end

	def logout
	  reset_session
	  flash[:notice] = "You have been logged out"
	  redirect_to :action => :login
	end

	def profile
		@user = User.find(session["user_id"])
		@display = "kindly post your ideas to get started"

		#@photo = Photo.find_by_user_id(session[:user_id])
		#if @photo == nil
		#	redirect_to :action => "asdfaf" # :action => "profile"
		#	@photo = Photo.new
		#end
	end

	def photo
		
	end
	
	#Photo_Upload
	def post_photo
		require 'fileutils'
		photo = Photo.new
		photo.user_id = session["user_id"]
		photo.created_at = DateTime.now
	
 		photo.file_name = params[:photo].original_filename
 		tmp = params[:photo].tempfile
 		uploaded_file = params[:photo]

  		file = File.new(Rails.root.join('public', 'images', uploaded_file.original_filename), 'wb')
		file.write(uploaded_file.read)
  		photo.save
  		redirect_to "/user/profile/#{session["user_id"]}"
	end

    private
	# Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def user_params
       params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
	
	def photo_params
       #params.permit(:photos_attributes => ['id', 'file_name', 'created_at', 'user_id'])
		params.fetch(:photo, {}).permit(:id, :file_name, :created_at, :user_id)
    end
end
