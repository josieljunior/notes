class Views::Memos::Form < Views::Base
  def initialize(memo:, tags:, url:, method: :post)
    @memo = memo
    @tags = tags
    @url = url
    @method = method
  end

  def view_template
    Card(class: "p-8") do
      if @memo.errors.any?
        div(class: "mb-6 p-4 bg-red-50 border border-red-200 rounded-lg") do
          h3(class: "text-lg font-semibold text-red-800 mb-2") do
            "#{@memo.errors.count} erro#{@memo.errors.count > 1 ? 's' : ''} #{@memo.errors.count > 1 ? 'impediram' : 'impediu'} que esta nota fosse salva:"
          end
          ul(class: "list-disc list-inside text-red-700 space-y-1") do
            @memo.errors.full_messages.each do |message|
              li { message }
            end
          end
        end
      end

      form_with model: @memo, url: @url, method: @method, local: true, class: "space-y-6" do |form|
        div do
          label(class: "block text-sm font-medium text-gray-700 mb-2") { "Título" }
          Input(
            name: "memo[title]",
            value: @memo.title,
            placeholder: "Digite o título da nota...",
            class: "w-full"
          )
        end

        div do
          label(class: "block text-sm font-medium text-gray-700 mb-2") { "Conteúdo" }
          Textarea(
            name: "memo[content]",
            value: @memo.content,
            placeholder: "Digite o conteúdo da nota...",
            rows: 8,
            class: "w-full"
          )
        end

        if @tags.any?
          div do
            label(class: "block text-sm font-medium text-gray-700 mb-3") { "Tags" }
            div(class: "grid grid-cols-2 md:grid-cols-3 gap-3") do
              @tags.each do |tag|
                div(class: "flex items-center space-x-2") do
                  input(
                    type: "checkbox",
                    name: "memo[tag_ids][]",
                    value: tag.id,
                    id: "tag_#{tag.id}",
                    checked: @memo.tag_ids.include?(tag.id),
                    class: "rounded border-gray-300 text-blue-600 focus:ring-blue-500"
                  )
                  label(
                    for: "tag_#{tag.id}",
                    class: "text-sm text-gray-700 cursor-pointer"
                  ) { tag.name.capitalize }
                end
              end
            end
          end
        end

        div(class: "flex gap-4 pt-4") do
          Button(variant: :primary, type: :submit) do
            @memo.persisted? ? "Atualizar Nota" : "Criar Nota"
          end

          Link(href: @memo.persisted? ? memo_path(@memo) : memos_path, variant: :outline) { "Cancelar" }
        end
      end
    end
  end
end
