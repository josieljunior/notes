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
        h1(class: "text-4xl font-bold text-gray-900") { "Memos" }

        div(class: "flex justify-center") do
          if @show_archived
            Link(href: memos_path, variant: :primary) { "Ver Memos Ativos" }
          else
            Link(href: memos_path(archived: true), variant: :secondary) { "Ver Memos Arquivados" }
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
              Link(href: memos_path(tag: tag.name)) do
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

      div(class: "text-center") do
        if params[:search].present?
          p(class: "text-lg text-gray-600") do
            strong { "Resultados para: " }
            span(class: "text-blue-600") { "\"#{params[:search]}\"" }
            span { " (#{@memos.count} #{@memos.count == 1 ? 'resultado' : 'resultados'})" }
          end
        elsif params[:tag].present?
          p(class: "text-lg text-gray-600") do
            strong { "Memos com a tag: " }
            Badge(variant: :primary) { params[:tag] }
            span { " (#{@memos.count} #{@memos.count == 1 ? 'memo' : 'memos'})" }
          end
        elsif @show_archived
          p(class: "text-lg text-gray-600") do
            strong { "Memos Arquivados: " }
            span { "#{@memos.count} #{@memos.count == 1 ? 'memo' : 'memos'}" }
          end
        else
          p(class: "text-lg text-gray-600") do
            strong { "Memos Ativos: " }
            span { "#{@memos.count} #{@memos.count == 1 ? 'memo' : 'memos'}" }
          end
        end
      end

      if @memos.any?
        div(class: "grid gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4") do
          @memos.each do |memo|
            link_to memo do
              div(class: "group hover:shadow-lg transition-shadow duration-200 cursor-pointer") do
                render Views::Memos::Card.new(memo)
              end
            end
          end
        end
      else
        Card(class: "p-12 text-center") do
          div(class: "space-y-4") do
            h3(class: "text-xl font-semibold text-gray-600") { "Nenhum memo encontrado" }
            p(class: "text-gray-500") { "Que tal criar o seu primeiro memo?" }
          end
        end
      end

      div(class: "text-center pt-8") do
        Link(href: new_memo_path, variant: :primary, size: :lg) { "Criar Novo Memo" }
      end
    end
  end
end
