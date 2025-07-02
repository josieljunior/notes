class MemosController < ApplicationController
  def index
    @memos = Memo.all
  end

  def create
    result = MemoCreator.call(memo_params)
    if result.success?
      redirect_to memos_path, notice: "Nota criada com sucesso."
    else
      @memo = result.model
      render :new, alert: result.errors
    end
  end

  def new
    @memo = Memo.new
  end

  def show
    @memo = Memo.find(params[:id])
  end

  def memo_params
    params.require(:memo).permit(:title, :content)
  end
end
