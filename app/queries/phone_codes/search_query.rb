# Accepts string of search terms
# Looks up by words in columns "comment" and "usage"
# Looks up by prefix in column "prefix"

module PhoneCodes
  class SearchQuery
    def self.call(str = '')
      terms = str.downcase.split(' ').join("|")
      CommentsQuery.call(str).or(PrefixesQuery.call(str).or(UsagesQuery.call(str)))
    end
  end
end
