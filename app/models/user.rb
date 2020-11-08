class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #退会機能       
  enum is_deleted: {Availble: false, Invalid: true}
  
  def active_for_authentication?
    super &&(self.is_deleted == "Availble")
  end
end
