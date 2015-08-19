# coding: UTF-8

require 'securerandom'

class UserService
  attr_accessor :user_name
  attr_reader :user_id

  def initialize
    pwd = Dir::pwd
    @file_path = File.join(pwd, 'user.dat')
    init
  end

  def init
    if File.exist? @file_path
      @user_id, @user_name = load_user
      puts "#{@user_id}, #{@user_name}"
    else
      @user_id, @user_name =  SecureRandom.uuid, '小空雅游客' + rand(1000).to_s
      save
    end
  end

  def save
    save_user(@user_id, @user_name)
  end

  private

  def load_user
    File.open(@file_path, 'r') do |f|
      lines = f.readlines
      return lines[0].chomp, lines[1].chomp
    end
  end

  def save_user(user_id, user_name)
    File.open(@file_path, 'w') do |f|
      f.puts user_id
      f.puts user_name
    end
  end
end