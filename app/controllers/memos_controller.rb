class MemosController < ApplicationController
  def index
    base_scope = params[:archived] == "true" ? Memo.archived : Memo.active

    @memos = if params[:search].present?
               base_scope.search_by_keyword(params[:search])
    elsif params[:tag].present?
               base_scope.tagged_with(params[:tag])
    else
               base_scope.all
    end
    @tags = Tag.ordered
    @show_archived = params[:archived] == "true"
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
    @tags = Tag.ordered
  end

  def show
    @memo = Memo.find(params[:id])
  end

  def edit
    @memo = Memo.find(params[:id])
    @tags = Tag.ordered
  end

  def update
    @memo = Memo.find(params[:id])
    if @memo.update(memo_params)
      redirect_to @memo, notice: "Memo atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    redirect_to memos_path, notice: "Memo deletado com sucesso."
  end

  def memo_params
    params.require(:memo).permit(:title, :content, tag_ids: [])
  end
end
