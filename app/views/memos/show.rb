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
        Link(href: memos_path, variant: :link, size: :sm) { "← Voltar para Notas" }
      end

      Card(class: "p-8") do
        div(class: "mb-6 border-b border-gray-200 pb-6") do
          h1(class: "text-4xl font-bold text-gray-900 mb-4") { @memo.title }

          if @memo.tags.any?
            div(class: "flex flex-wrap gap-2") do
              @memo.tags.each do |tag|
                Badge(variant: :primary) { "##{tag.name}" }
              end
            end
          end

          div(class: "mt-4 flex items-center space-x-4 text-sm text-gray-500") do
            if @memo.archived?
              Badge(variant: :gray) { "Arquivado" }
            else
              Badge(variant: :success) { "Ativo" }
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
          Link(href: edit_memo_path(@memo), variant: :primary) { "Editar Nota" }

          if @memo.archived?
            Form(action: unarchive_memo_path(@memo), method: :patch) do
              Button(type: :submit, variant: :secondary) { "Desarquivar" }
            end
          else
            Form(action: archive_memo_path(@memo), method: :patch) do
              Button(type: :submit, variant: :outline) { "Arquivar" }
            end
          end

          Form(action: memo_path(@memo), method: :delete) do
            Button(type: :submit, variant: :destructive) { "Excluir Nota" }
          end
        end
      end
    end
  end
end
