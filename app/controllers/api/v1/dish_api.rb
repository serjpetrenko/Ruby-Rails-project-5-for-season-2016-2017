module API
  module V1
    include UsersHelper
    class DishAPI < Grape::API

      resource :dishes do
        desc 'Returns all dishes.'
        get do
          if UsersHelper.authorize(self)
            dishes = Dish.all
            present dishes, with: Entities::DishEntity
          end
        end

        desc 'Creates new restaurant.'
        params do
          requires :dish_params, type: Hash do
            requires :name, type: String, desc: 'Dish name.'
            requires :description, type: String, desc: 'Description.'
            requires :price, type: Integer, desc: 'Price.'
            requires :weight, type: Float, desc: 'Weight.'
            requires :picture, type: String, desc: 'Picture url.'
          end
        end
        post do
          if UsersHelper.authorize(self)
            dish = Dish.new(declared(params, include_missing: false)[:dish_params])
            dish.save
            present dish, with: Entities::DishEntity
          end
        end

        desc 'Update price, picture.'
        params do
          requires :id, type: String, desc: 'Dish id '
          requires :price, type: String, desc: 'Change price '
          requires :picture, type: String, desc: 'Change picture.'
        end
        put ':id' do
          if UsersHelper.authorize(self)
            update_dish = Dish.find(params[:id]).update(
              price: params[:price],
              picture: params[:picture]
            )
            if update_dish
              { 'id': params[:id], 'price':params[:price], 'picture': params[:picture]}
            else
              { 'error': update_dish.errors.messages }
            end
          end
        end

        desc 'Delete dish.'
        params do
          requires :id, type: String, desc: 'Dish id.'
        end
        delete ':id' do
          if UsersHelper.authorize(self)
            Dish.find(params[:id]).destroy!
          end
        end
      end
    end
  end
end
