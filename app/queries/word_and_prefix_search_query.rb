# Accepts array or search terms
# Looks up by words in columns "comment" and "usage"
# Looks up by prefix in column "prefix"

class WordAndPrefixSearchQuery
  def self.call(query)
    query ||= ''
    terms = query.downcase.split(' ').join("|")
    PhoneCode.where("LOWER(comment) ~ ? OR LOWER(usage) ~ ? OR CAST(prefix AS text) ~ ?", terms, terms, terms)
  end
end
