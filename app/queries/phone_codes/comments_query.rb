# Subquery for search based on comments
# comments column may contain umlauts. So it handles thosse as well

module PhoneCodes
  class CommentsQuery
    def self.call(str)
      terms = str.downcase.split(' ').join("|")
      PhoneCode.where("""
        LOWER(comment) ~ ? OR
        LOWER(#{self.normalize_umlauts('comment')}) ~ ? OR
        LOWER(UNACCENT(comment)) ~ ?
      """, terms, terms, terms)
    end

    private

    def self.normalize_umlauts(column)
      "REPLACE( REPLACE( REPLACE( REPLACE( #{column}, 'ä','ae'), 'ö','oe' ), 'ü','ue'), 'ß','ss' )"
    end
  end
end
