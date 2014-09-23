class Word < ActiveRecord::Base
  has_many :definitions
  before_save { self.name = name.downcase }

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
end
