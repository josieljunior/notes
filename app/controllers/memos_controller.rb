class MemosController < ApplicationController
  include Pageable

  MEMOS_PER_PAGE = 8

  def index
    memos_collection = MemoSearch.find_by_search_and_tag(
      search: params[:search],
      tag: params[:tag],
      archived: params[:archived] == "true"
    ).includes(:tags)

    @pagination, @memos = paginate(
      collection: memos_collection,
      params: page_params
    )

    @tags = Tag.ordered
    @show_archived = params[:archived] == "true"

    render Views::Memos::Index.new(
      params: params,
      memos: @memos,
      pagination: @pagination,
      notice: flash[:notice],
      show_archived: @show_archived,
      tags: @tags
    )
  end

  def create
    result = MemoCreator.call(memo_params)
    if result.success?
      redirect_to memos_path, notice: "Nota criada com sucesso."
    else
      @memo = result.model
      @tags = Tag.ordered
      render Views::Memos::New.new(
        memo: @memo,
        tags: @tags
      )
    end
  end

  def new
    @memo = Memo.new
    @tags = Tag.ordered

    render Views::Memos::New.new(
      memo: @memo,
      tags: @tags
    )
  end

  def show
    @memo = Memo.find(params[:id])

    render Views::Memos::Show.new(
      memo: @memo,
      notice: flash[:notice]
    )
  end

  def edit
    @memo = Memo.find(params[:id])
    @tags = Tag.ordered

    render Views::Memos::Edit.new(
      memo: @memo,
      tags: @tags
    )
  end

  def update
    @memo = Memo.find(params[:id])
    if @memo.update(memo_params)
      redirect_to @memo, notice: "Memo atualizado com sucesso."
    else
      @tags = Tag.ordered
      render Views::Memos::Edit.new(
        memo: @memo,
        tags: @tags
      )
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    redirect_to memos_path, notice: "Memo deletado com sucesso."
  end

  def archive
    @memo = Memo.find(params[:id])
    @memo.archive!
    redirect_to @memo, notice: "Memo arquivado com sucesso."
  end

  def unarchive
    @memo = Memo.find(params[:id])
    @memo.unarchive!
    redirect_to @memo, notice: "Memo desarquivado com sucesso."
  end

  private

  def memo_params
    params.require(:memo).permit(:title, :content, tag_ids: [])
  end

  def page_params
    params.permit(:page).merge(per_page: MEMOS_PER_PAGE)
  end
end
