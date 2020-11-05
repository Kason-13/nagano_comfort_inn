# == Schema Information
#
# Table name: view_types
#
#  id         :integer          not null, primary key
#  view       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



class ViewType < ActiveRecord::Base
  attr_accessible :view, :price

  has_many :rooms

  validates(:view, presence:true)
  validates(:price, presence:true)
end
