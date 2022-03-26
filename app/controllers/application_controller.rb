class ApplicationController < ActionController::Base
    def verify_shop
        if (params[:shop_id])
          getShop = Shop.find(params[:shop_id])
          if !getShop.nil?
            @shopID = getShop
          else
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
    end
end
