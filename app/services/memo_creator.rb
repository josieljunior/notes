class MemoCreator
  def self.call(params)
    memo = Memo.new(params)

    if memo.save
      Result.success(memo)
    else
      Result.failure(memo, memo.errors.full_messages)
    end
  end
end
