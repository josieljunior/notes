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
    div(class: "max-w-7xl mx-auto space-y-8") do
      if notice.present?
        div(class: "p-4 bg-green-50 border border-green-200 rounded-lg") do
          p(class: "text-green-800 font-medium") { notice }
        end
      end

      div(class: "text-center space-y-4") do
        h1(class: "text-4xl font-bold text-gray-900") { "Notas" }

        div(class: "flex justify-center gap-2") do
          Link(href: new_memo_path, variant: :primary, size: :lg) { "Criar Nova Nota" }

          if @show_archived
            Link(href: memos_path, variant: :secondary, size: :lg) { "Ver Notas Ativas" }
          else
            Link(href: memos_path(archived: true), variant: :secondary, size: :lg) { "Ver Notas Arquivadas" }
          end
        end
      end

      Card(class: "p-6") do
        form_with url: memos_path, method: :get, local: true, class: "space-y-4" do |form|
          div(class: "flex gap-4") do
            div(class: "flex-1") do
              Input(
                placeholder: "Pesquisar por título ou conteúdo...",
                value: params[:search],
                name: "search",
                class: "w-full"
              )
            end
            div do
              Button(type: :submit, variant: :primary) { "Pesquisar" }
            end
          end

          if params[:search].present?
            div(class: "flex justify-start") do
              Link(href: memos_path, variant: :link, size: :sm) { "Limpar" }
            end
          end
        end
      end

      if @tags.any?
        Card(class: "p-6") do
          h3(class: "text-lg font-semibold mb-4") { "Filtrar por tags:" }
          div(class: "flex flex-wrap gap-2 justify-center") do
            @tags.each do |tag|
              active_variant = params[:tag] == tag.name ? :primary : :outline
              Link(href: memos_path(tag: tag.name), variant: :none) do
                Badge(variant: active_variant, size: :lg) { tag.name }
              end
            end

            if params[:tag].present?
              Link(href: memos_path) do
                Badge(variant: :destructive) { "Limpar filtro" }
              end
            end
          end
        end
      end

      if @memos.any?
        div(class: "grid gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4") do
          @memos.each do |memo|
            link_to memo do
              div(class: "group hover:shadow-lg transition-shadow duration-200 cursor-pointer h-full") do
                render Views::Memos::Card.new(memo)
              end
            end
          end
        end
      else
        Card(class: "p-12 text-center") do
          div(class: "space-y-4") do
            h3(class: "text-xl font-semibold text-gray-600") { "Nenhuma nota encontrada" }
            p(class: "text-gray-500") { "Que tal criar a sua primeira nota?" }
          end
        end
      end
    end
  end
end
