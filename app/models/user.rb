require "bcrypt"

class User < ApplicationRecord
  include BCrypt

  # Valida la presencia y unicidad de los campos de usuario
  validates :user_mail, presence: true, uniqueness: true
  validates :user_name, presence: true
  validates :user_password, presence: true

  # Método para establecer la contraseña cifrada
  def password=(new_password)
    self.user_password = Password.create(new_password)
  end

  # Método para autenticar la contraseña
  def authenticate(input_password)
    self.user_password == input_password
  end
end
