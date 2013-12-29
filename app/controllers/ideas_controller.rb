class IdeasController < ApplicationController
	def index
	end

	def new
		@idea = Idea.new
	end

	def post_new
		@idea = Idea.create(idea_params)
		#idea_params['overall_rank'] = 0
		#idea_params['votes'] = 0
		#idea_params['purchased'] = 0

		params[:user_id] = session["user_id"]

		if @idea.valid?
			@idea.save
			redirect_to :controller => 'user', :action => 'profile'
		else
			flash[:notice] = @idea.errors.full_messages
			redirect_to :controller => 'ideas', :action => 'debug'
		end
	end
	
	def debug

	end

	private
	# Using a private method to encapsulate the permissible parameters
    # is just a good pattern since you'll be able to reuse the same
    # permit list between create and update. Also, you can specialize
    # this method with per-user checking of permissible attributes.
    def user_params
       params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
	
	def idea_params
        params.fetch(:idea,{}).permit(:user_id, :id, :summary, :created_at, :updated_at, :user_id, :overall_rank, :personal_interest,:sector, :purchased, :description, :votes)
		#params.fetch(:photo, {}).permit(:id, :file_name, :created_at, :user_id)
    end

end
