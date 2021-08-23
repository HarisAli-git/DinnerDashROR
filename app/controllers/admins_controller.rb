class AdminsController < ApplicationController
    
    def index
        if user_signed_in?
            @user = User.where(id: current_user.id).take!
        end
    end

    def show
        
    end

    def get_orders
        
    end

    def get_items
        
    end

    def get_users
        
    end



end
