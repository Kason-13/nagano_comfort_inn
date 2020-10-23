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
  attr_accessible :price, :view

  validates(:view, presence:true)
end
