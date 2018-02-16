class User < ApplicationRecord
  attr_accessor :remember_token
  before_save {self.email=self.email.downcase}
  validates :name,presence:true,length:{maximum:50}
  validates :email,presence:true,length:{maximum:255},
                   format:{with:/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                   uniqueness:{case_sensitive:false}
  has_secure_password
  validates :password,length:{minimum:6},allow_nil:true
  has_secure_password


  # 返回指定字符串的哈希摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  def remember#把记忆令牌和用户关联起来，把记忆摘要存入数据库
    self.remember_token=User.new_token
    update_attribute(:remember_digest,User.digest(remember_token))
  end
  def forget
    update_attribute(:remember_digest,nil)
  end
  def authenticated?(remeber_token)
    BCrypt::Password.new(remember_digest).is_password?(remeber_token)
  end
end
