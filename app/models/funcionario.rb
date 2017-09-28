class Funcionario < ApplicationRecord
  has_many :horarios
  belongs_to :user
  validates :nome, presence: true
  validates :cpf, presence: true
end
