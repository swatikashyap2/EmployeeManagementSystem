class TeamsController < ApplicationController

    def index
        @users = User.all.paginate(page: params[:page], per_page: 10)
        @managers = User.manager
    end

    def search 
        @users = User.all
        @users = @users.where(id: params[:id]) if params[:id].present?
        @users = @users.where(designation: params[:designation]) if params[:designation].present?
        @users = @users.paginate(page: params[:page], per_page: 10)
        respond_to do|format|
            format.js
        end
    end
end
