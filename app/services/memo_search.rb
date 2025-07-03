class MemoSearch
  def self.find_by_search_and_tag(search: nil, tag: nil, archived: false)
    base_scope = archived ? Memo.archived : Memo.active

    if search.present?
      base_scope.search_by_keyword(search)
    elsif tag.present?
      base_scope.tagged_with(tag)
    else
      base_scope.all
    end
  end
end
