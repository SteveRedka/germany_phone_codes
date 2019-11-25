# Subquery for search based on usage
# Usage seems to be English only, so it only looks for likeness

module PhoneCodes
  class UsagesQuery
    def self.call(str)
      terms = str.downcase.split(' ').join("|")
      PhoneCode.where("""
        LOWER(usage) ~ ?
      """, terms)
    end
  end
end
