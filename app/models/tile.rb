class Tile < ActiveRecord::Base
  ##
  # Associations
  #
  belongs_to :game

  ##
  # Validations
  #
  validates_presence_of :game

end
