# Accepts array or search terms
# Looks up by words in columns "comment" and "usage"
# Looks up by prefix in column "prefix"

module PhoneCodes
  class SearchQuery
    def self.call(str)
      str ||= ''
      terms = str.downcase.split(' ').join("|")
      PhoneCode.where("""
        LOWER(#{self.normalize_accents_sql('comment')}) ~ ?
        OR CAST(prefix AS text) ~ ?
        OR LOWER(usage) ~ ?
      """, terms, terms, terms)
    end

    protected

    def self.normalize_accents_sql(column)
      "REPLACE( REPLACE( REPLACE( REPLACE( #{column}, 'ä','ae'), 'ö','oe' ), 'ü','ue'), 'ß','ss' )"
    end
  end
end
