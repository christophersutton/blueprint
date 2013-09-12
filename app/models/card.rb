class Card < ActiveRecord::Base
	validates :title, presence: true
	validates :card_type, presence: true
	validates :position, presence: true
	has_many :children, :class_name => "Card", :foreign_key => "parent_id"
  	belongs_to :parent, :class_name => "Card",:foreign_key => "parent_id"

	def self.card_types
	 ['Physical Evidence','Customer Action','Frontstage','Backstage','Supporting Processes']
	end

end
