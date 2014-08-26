class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sittings
  has_many :earned_badges
  has_many :badge_types, through: :earned_badges
  belongs_to :quote_list

  before_create :set_quote_list

  def set_quote_list
    self.quote_list = QuoteList.first
  end

end
