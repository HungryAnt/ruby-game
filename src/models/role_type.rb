class RoleType
  WAN_GYE = :wangye # ¼¦µ°
  SALARY = :salary
  BANGYE = :bangye # °ë¸ö¼¦µ°
  DOOBU = :doobu
  KIMCHI = :kimchi
  MANL = :manl
  MOO = :moo
  PASERY = :pasery
  PIMENTO = :pimento
  RICE = :rice
  YANGBEA = :yangbea
  YANGPA = :yangpa

  @@all_role_types = [WAN_GYE, SALARY, BANGYE, DOOBU, KIMCHI, MANL, MOO, PASERY, PIMENTO, RICE, YANGBEA, YANGPA]
  @@roles_len = @@all_role_types.length

  def self.default
    YANGPA
  end

  def self.get_all_types
    @@all_role_types
  end

  def self.random
    @@all_role_types[rand(@@roles_len)]
  end

  def self.next(role_type)
    next_index = (get_index_of(role_type) + 1) % @@roles_len
    @@all_role_types[next_index]
  end

  def self.prev(role_type)
    preve_index = (get_index_of(role_type) - 1 + @@roles_len) % @@roles_len
    @@all_role_types[preve_index]
  end

  def self.get_index_of(role_type)
    0.upto(@@roles_len  - 1) {|i| return i if role_type == @@all_role_types[i]}
    return -1
  end

  def self.from(role_type_text)
    return default if role_type_text.nil? || role_type_text.chomp == ''
    role_type = role_type_text.to_sym
    return default if get_index_of(role_type) < 0
    role_type
  end
end