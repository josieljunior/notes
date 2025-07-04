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
    # Container principal com padding e espaçamento
    div(class: "max-w-7xl mx-auto space-y-8") do
      # Notice
      if notice.present?
        div(class: "p-4 bg-green-50 border border-green-200 rounded-lg") do
          p(class: "text-green-800 font-medium") { notice }
        end
      end

      # Header da página
      div(class: "text-center space-y-4") do
        h1(class: "text-4xl font-bold text-gray-900") { "Memos" }

        # Toggle arquivados
        div(class: "flex justify-center") do
          if @show_archived
            link_to memos_path do
              Button(variant: :primary) { "Ver Memos Ativos" }
            end
          else
            link_to memos_path(archived: true) do
              Button(variant: :secondary) { "Ver Memos Arquivados" }
            end
          end
        end
      end

      # Formulário de busca
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
              link_to memos_path do
                Button(variant: :link, size: :sm) { "Limpar" }
              end
            end
          end
        end
      end

      # Filtro de tags
      if @tags.any?
        Card(class: "p-6") do
          h3(class: "text-lg font-semibold mb-4") { "Filtrar por tags:" }
          div(class: "flex flex-wrap gap-2") do
            @tags.each do |tag|
              active_class = params[:tag] == tag.name ? "primary" : "outline"
              link_to memos_path(tag: tag.name) do
                Badge(color: active_class.to_sym) { tag.name }
              end
            end

            if params[:tag].present?
              link_to memos_path do
                Badge(color: :destructive) { "Limpar filtro" }
              end
            end
          end
        end
      end

      # Contador de resultados
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
            Badge(color: :primary) { params[:tag] }
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

      # Grid de cards
      if @memos.any?
        div(class: "grid gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4") do
          @memos.each do |memo|
            div(class: "group hover:shadow-lg transition-shadow duration-200") do
              render Views::Memos::Card.new(memo)

              # Actions card
              div(class: "mt-4 p-4 bg-gray-50 rounded-lg border border-gray-200") do
                div(class: "flex flex-wrap justify-center gap-3 text-sm") do
                  link_to memo do
                    Button(variant: :outline, size: :sm) { "Ver" }
                  end

                  link_to edit_memo_path(memo) do
                    Button(variant: :secondary, size: :sm) { "Editar" }
                  end

                  if memo.archived?
                    button_to unarchive_memo_path(memo),
                              method: :patch,
                              data: {
                                confirm: "Tem certeza que deseja desarquivar este memo?"
                              } do
                      Button(variant: :outline, size: :sm) { "Desarquivar" }
                    end
                  else
                    button_to archive_memo_path(memo),
                              method: :patch,
                              data: {
                                confirm: "Tem certeza que deseja arquivar este memo?"
                              } do
                      Button(variant: :ghost, size: :sm) { "Arquivar" }
                    end
                  end

                  link_to memo,
                          method: :delete,
                          data: {
                            confirm: "Tem certeza?"
                          } do
                    Button(variant: :destructive, size: :sm) { "Excluir" }
                  end
                end
              end
            end
          end
        end
      else
        # Estado vazio
        Card(class: "p-12 text-center") do
          div(class: "space-y-4") do
            h3(class: "text-xl font-semibold text-gray-600") { "Nenhum memo encontrado" }
            p(class: "text-gray-500") { "Que tal criar o seu primeiro memo?" }
          end
        end
      end

      # Botão novo memo
      div(class: "text-center pt-8") do
        link_to new_memo_path do
          Button(variant: :primary, size: :lg) { "Criar Novo Memo" }
        end
      end
    end
  end
end
