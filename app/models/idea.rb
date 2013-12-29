class Idea < ActiveRecord::Base
  has_many :comments
  has_many :stars
  belongs_to :user
  has_and_belongs_to_many :sectors

  validates_presence_of :summary, :description, :sector, :personal_interest #:votes, :purchased, :overall_rank
  validates :summary, :presence => true, :length => { :minimum => 20, :maximum => 140}, :confirmation => true
  validates :description, :presence => true, :length => { :minimum => 100, :maximum => 500}, :confirmation => true
end
