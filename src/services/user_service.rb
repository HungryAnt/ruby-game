# coding: UTF-8

require 'securerandom'

class UserService
  attr_accessor :user_name
  attr_reader :user_id

  def initialize
    @user_id = SecureRandom.uuid
    @user_name = '小空雅游客'
  end
end