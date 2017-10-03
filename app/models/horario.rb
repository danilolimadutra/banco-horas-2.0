class Horario < ApplicationRecord
  belongs_to :user
  belongs_to :funcionario
  validates :data, presence: true
  validates :inicio, presence: true
  validates :fim, presence: true
  validates :motivo, presence: true, length: { minimum: 5 }
  
end
