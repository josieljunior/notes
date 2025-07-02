class MemoObserver < ActiveRecord::Observer
  def after_create(memo)
    Rails.logger.info "Uma nova nota foi criada: #{memo.title} (ID: #{memo.id})"
  end
end
