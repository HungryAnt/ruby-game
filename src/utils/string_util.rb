require_relative 'character_util'

class StringUtil
  def self.split_lines(raw_text, max_char_count_per_line)
    text = raw_text.gsub /\n\r/, "\n"
    line_char_count = 0
    line = ''
    lines = []
    text.each_char do |char|
      en_char_count = CharacterUtil.is_cjk_char(char) ? 2 : 1
      if char == "\n" || line_char_count + en_char_count > max_char_count_per_line
        lines << line
        line = ''
        line_char_count = 0
        if char == "\n"
          next
        end
      end
      line << char
      line_char_count += en_char_count
    end
    lines << line if line.length > 0
    return lines
  end

  def self.camel_to_underline(str)
    str.gsub(/(.)([A-Z])/, '\1_\2').downcase
  end

  def self.underline_to_camel(str)
    str.tr('_', ' ').gsub(/\b\w/) { |first| first.upcase }.tr(' ', '')
  end
end