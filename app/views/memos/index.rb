class Views::Memos::Index < Views::Base
  attr_accessor :notice, :params

  def initialize(memos:, notice:, params:, show_archived:, tags:)
    @memos = memos
    @notice = notice
    @params = params
    @show_archived = show_archived
    @tags = tags
  end

  def view_template
    p(style: "color:#008000") { notice }

    content_for :title, "Memos"

    h1 { "Memos" }

    div(class: "archive-toggle") do
      whitespace
      if @show_archived
        whitespace
        link_to "Ver Memos Ativos", memos_path, class: "archive-link"
        whitespace
      else
        whitespace
        link_to "Ver Memos Arquivados",
                memos_path(archived: true),
                class: "archive-link"
        whitespace
      end
    end

    div(class: "search-form") do
      whitespace
      form_with url: memos_path, method: :get, local: true do |form|
        whitespace
        plain form.text_field :search,
                              placeholder:
                                "Pesquisar por título ou conteúdo...",
                              value: params[:search]
        whitespace
        plain form.submit "Pesquisar"
        whitespace
        if params[:search].present?
          whitespace
          link_to "Limpar", memos_path
          whitespace
        end
        whitespace
      end
    end

    if @tags.any?
      div(class: "tags-filter") do
        h3 { "Filtrar por tags:" }
        whitespace
        @tags.each do |tag|
          whitespace
          link_to tag.name,
                  memos_path(tag: tag.name),
                  class: "tag-filter #{"active" if params[:tag] == tag.name}"
          whitespace
        end
        whitespace
        if params[:tag].present?
          whitespace
          link_to "Todas", memos_path, class: "tag-filter clear"
          whitespace
        end
      end
    end

    div(id: "memos", class: "space-y-6") do
      whitespace
      if params[:search].present?
        p do
          strong { "Resultados para:" }
          plain %( ")
          plain params[:search]
          plain %(" ()
plain @memos.count
whitespace
plain @memos.count == 1 ? 'resultado' : 'resultados'
plain %())
        end
        whitespace
      elsif params[:tag].present?
        p do
          strong { "Memos com a tag:" }
          plain %( ")
          plain params[:tag]
          plain %(" ()
plain @memos.count
whitespace
plain @memos.count == 1 ? 'memo' : 'memos'
plain %())
        end
        whitespace
      elsif @show_archived
        p do
          strong { "Memos Arquivados:" }
          plain " ()
plain @memos.count
whitespace
plain @memos.count == 1 ? 'memo' : 'memos'
plain %()"
        end
        whitespace
      else
        p do
          strong { "Memos Ativos:" }
          plain " ()
plain @memos.count
whitespace
plain @memos.count == 1 ? 'memo' : 'memos'
plain %()"
        end
        whitespace
      end
      whitespace

      div(class: "grid gap-6 md:grid-cols-2 lg:grid-cols-3") do
        @memos.each do |memo|
          div(class: "relative") do
            render Views::Memos::Card.new(memo)

            div(class: "mt-4 flex flex-wrap gap-2 text-sm justify-center") do
              link_to "Ver", memo, class: "text-blue-600 hover:text-blue-800"
              plain " | "
              link_to "Editar", edit_memo_path(memo), class: "text-green-600 hover:text-green-800"
              plain " | "
              if memo.archived?
                button_to "Desarquivar",
                          unarchive_memo_path(memo),
                          method: :patch,
                          class: "text-yellow-600 hover:text-yellow-800 bg-transparent border-none p-0 underline cursor-pointer",
                          data: {
                            confirm: "Tem certeza que deseja desarquivar este memo?"
                          }
                plain " | "
              else
                button_to "Arquivar",
                          archive_memo_path(memo),
                          method: :patch,
                          class: "text-orange-600 hover:text-orange-800 bg-transparent border-none p-0 underline cursor-pointer",
                          data: {
                            confirm: "Tem certeza que deseja arquivar este memo?"
                          }
                plain " | "
              end
              link_to "Excluir",
                      memo,
                      method: :delete,
                      class: "text-red-600 hover:text-red-800",
                      data: {
                        confirm: "Tem certeza?"
                      }
            end
          end
        end
      end
    end

    link_to "New memo", new_memo_path
  end
end
