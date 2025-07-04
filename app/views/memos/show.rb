class Views::Memos::Show < Views::Base
  def initialize(memo:, notice:)
    @memo = memo
    @notice = notice
  end

  def view_template
    div(class: "max-w-4xl mx-auto space-y-8") do
      if @notice.present?
        div(class: "p-4 bg-green-50 border border-green-200 rounded-lg") do
          p(class: "text-green-800 font-medium") { @notice }
        end
      end

      div(class: "flex items-center space-x-2 text-sm text-gray-600") do
        link_to memos_path do
          Button(variant: :link, size: :sm) { "← Voltar para Memos" }
        end
      end

      Card(class: "p-8") do
        div(class: "mb-6 border-b border-gray-200 pb-6") do
          h1(class: "text-4xl font-bold text-gray-900 mb-4") { @memo.title }

          if @memo.tags.any?
            div(class: "flex flex-wrap gap-2") do
              @memo.tags.each do |tag|
                Badge(color: :primary) { "##{tag.name}" }
              end
            end
          end

          div(class: "mt-4 flex items-center space-x-4 text-sm text-gray-500") do
            if @memo.archived?
              Badge(color: :secondary) { "Arquivado" }
            else
              Badge(color: :success) { "Ativo" }
            end

            span { "Criado em #{@memo.created_at.strftime('%d/%m/%Y às %H:%M')}" }

            if @memo.updated_at != @memo.created_at
              span { "• Atualizado em #{@memo.updated_at.strftime('%d/%m/%Y às %H:%M')}" }
            end
          end
        end

        div(class: "prose max-w-none") do
          div(class: "text-lg leading-relaxed text-gray-700 whitespace-pre-wrap") do
            @memo.content
          end
        end
      end

      Card(class: "p-6") do
        h3(class: "text-lg font-semibold mb-4") { "Ações" }

        div(class: "flex flex-wrap gap-4") do
          link_to edit_memo_path(@memo) do
            Button(variant: :primary) { "Editar Memo" }
          end

          if @memo.archived?
            button_to "Desarquivar",
                      unarchive_memo_path(@memo),
                      method: :patch,
                      class: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 bg-secondary text-secondary-foreground hover:bg-opacity-80 px-4 py-2 h-9 text-sm",
                      data: {
                        confirm: "Tem certeza que deseja desarquivar este memo?"
                      }
          else
            button_to "Arquivar",
                      archive_memo_path(@memo),
                      method: :patch,
                      class: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 border border-input bg-background shadow-sm hover:bg-accent hover:text-accent-foreground px-4 py-2 h-9 text-sm",
                      data: {
                        confirm: "Tem certeza que deseja arquivar este memo?"
                      }
          end

          button_to "Excluir Memo",
                    memo_path(@memo),
                    method: :delete,
                    class: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 bg-destructive text-destructive-foreground shadow-sm hover:bg-destructive/90 px-4 py-2 h-9 text-sm",
                    data: {
                      confirm: "Tem certeza que deseja excluir este memo? Esta ação não pode ser desfeita."
                    }
        end
      end

      div(class: "text-center pt-4") do
        link_to new_memo_path do
          Button(variant: :outline, size: :lg) { "Criar Novo Memo" }
        end
      end
    end
  end
end
