class ViewType < ActiveRecord::Base
  attr_accessible :price, :view

  validates(:view, presence:true)
  validates(:price, presence:true)
end
