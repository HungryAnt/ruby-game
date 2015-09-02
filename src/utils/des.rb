class Des
  require 'openssl'
  require 'base64'

  def initialize(password)
    @des = OpenSSL::Cipher::Cipher.new('DES-EDE3-CBC')
    @des.pkcs5_keyivgen(password, 'AntYecai')
  end

  def encrypt(str)
    @des.encrypt
    cipher = @des.update(str)
    cipher << @des.final
    Base64.encode64(cipher).gsub! /\n/, '' # 转为base64编码后去除其中换行符
  end

  def decrypt(str)
    str = Base64.decode64(str)
    @des.decrypt
    @des.update(str) + @des.final
  end
end