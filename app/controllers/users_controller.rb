class UsersController < ApplicationController
    def create 
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    rescue ActiveRecord::RecordInvalid => invalid 
        render json: { errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def show 
        user = User.find_by_id(session[:user_id])
        if user 
            render json: user, status: :ok 
        else
            render json: {error: "Not authorized"}, status: :unauthorized
        end
    end

    private 

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
