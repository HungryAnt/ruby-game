# see http://stackoverflow.com/questions/2727804/how-to-determine-if-a-character-is-a-chinese-character
# do some refactor by Ant 2015-9-3 13:02:09

class CharacterUtil
  def self.is_cjk_char(char)
    value = char.unpack('U*')[0]

    #main blocks
    if value >= 0x4E00 && value <= 0x9FFF
      return true
    end
    #extended block A
    if value >= 0x3400 && value <= 0x4DBF
      return true
    end
    #extended block B
    if value >= 0x20000 && value <= 0x2A6DF
      return true
    end
    #extended block C
    if value >= 0x2A700 && value <= 0x2B73F
      return true
    end
    return false
  end
end