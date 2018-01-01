class Category < ApplicationRecord
    has_many :products,  dependent: :destroy

    validates_presence_of :name

    def self.get_category
      all
    end

    def self.create_category(category_params)
      create!(category_params)
    end

    def self.find_category(params)
      find(params[:id])
    end

end
