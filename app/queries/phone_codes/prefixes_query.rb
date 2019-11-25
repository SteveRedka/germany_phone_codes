# Subquery for search based on phone codes

module PhoneCodes
  class PrefixesQuery
    def self.call(str)
      terms = str.to_s.downcase.split(' ').join("|")
      PhoneCode.where("""
        CAST(prefix AS text) ~ ?
      """, terms)
    end
  end
end
