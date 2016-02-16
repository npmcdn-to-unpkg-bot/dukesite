class Admin < ActiveRecord::Base
  devise :database_authenticatable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable
end
