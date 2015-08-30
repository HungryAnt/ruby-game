# coding: UTF-8

require 'securerandom'

class UserService
  attr_accessor :user_name, :role_type
  attr_reader :user_id, :lv, :exp

  def initialize
    pwd = Dir::pwd
    @file_path = File.join(pwd, 'user.dat')
    init_user
    init_lv_exp
  end

  def init_user
    if !GameConfig::DEBUG && File.exist?(@file_path)
      @user_id, @user_name, @role_type = load_user
      puts "#{@user_id}, #{@user_name}"
    else
      @user_id, @user_name, @role_type =  SecureRandom.uuid, '小空雅游客' + rand(1000).to_s, RoleType.default
      save
    end
  end

  def init_lv_exp
    @lv = 1
    @exp = 0
    @lv_synced = false
  end

  def update_lv_exp(lv, exp)
    @lv, @exp = lv, exp
    @lv_synced = true
  end

  def lv_synced?
    @lv_synced
  end

  def save
    save_user(@user_id, @user_name, @role_type)
  end

  private

  def load_user
    File.open(@file_path, 'r:UTF-8') do |f|
      lines = f.readlines
      user_id = lines[0].chomp
      user_name = lines[1].chomp
      role_type = RoleType.default
      role_type = RoleType.from(lines[2].chomp) if lines.length > 2
      return user_id, user_name, role_type
    end
  end

  def save_user(user_id, user_name, role_type)
    File.open(@file_path, 'w:UTF-8') do |f|
      f.puts user_id
      f.puts user_name
      f.puts role_type.to_s
    end
  end
end