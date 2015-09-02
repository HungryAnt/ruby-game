class DesService
  def initialize
    @des = nil
  end

  def waiting_for_password?
    @des == nil
  end

  def set_password(password)
    @des = Des.new password
  end

  def encrypt(str)
    @des.encrypt str
  end

  def decrypt(str)
    @des.decrypt str
  end
end