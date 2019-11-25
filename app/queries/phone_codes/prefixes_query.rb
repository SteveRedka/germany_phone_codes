# Subquery for search based on phone codes

module PhoneCodes
  class PrefixesQuery
    VALID_PHONE_REGEX = /(?:\+|\d|\()(?:-|\(|\)|\d|\/|)+/
    # VALID_PHONE_WITH_POSSIBLE_TRAILING_SPACE = Regexp.new(/^| /.source + VALID_PHONE_REGEX.source)
    TRAILING_TRASH_REGEX = /^(0049|00|0|\(0|\+49\(0\)|\+49|\+0)/
    NON_NUMBER_REGEX = /[^\d]/

    def self.call(str)
      PhoneCode.where("""
        CAST(prefix AS text) IN (?)
      """, self.list_possible_prefixes(str))
    end

    def self.list_possible_prefixes(str)
      str.to_s.split(' ')
              .map { |s| s.scan(VALID_PHONE_REGEX)  }
              .flatten
              .map { |code| self.cleanup_phone_code(code) }
              .map { |code| self.reduce_prefix(code) }
              .flatten
              .uniq
    end

    private

    def self.cleanup_phone_code(str)
      str.gsub(TRAILING_TRASH_REGEX, '').gsub(NON_NUMBER_REGEX, '')
    end

    def self.reduce_prefix(str)
      # '7932' => ['7932', '793', '79', '7']
      result = []
      (0...str.length).each do |i|
        result << str[0..i]
      end
      result.reverse
    end
  end
end
