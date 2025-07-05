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
        Alert(variant: :destructive, class: "mb-6") do
          alert_icon
          AlertTitle { "Erro ao salvar a nota:" }
          AlertDescription do
            ul(class: "list-disc list-inside space-y-1 mt-2") do
              @memo.errors.full_messages.each do |message|
                li { message }
              end
            end
          end
        end
      end

      form_with model: @memo, url: @url, method: @method, local: true, data: { turbo: false }, class: "space-y-6" do |form|
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
            rows: 8
          )
        end

        if @tags.any?
          div do
            label(class: "block text-sm font-medium text-gray-700 mb-3") { "Tags" }
            CheckboxGroup(data_required: false) do
              div(class: "grid grid-cols-2 md:grid-cols-3 gap-3") do
                @tags.each do |tag|
                  div(class: "flex flex-row items-center gap-2") do
                    Checkbox(
                      value: tag.id,
                      id: "tag_#{tag.id}",
                      name: "memo[tag_ids][]",
                      checked: @memo.tag_ids.include?(tag.id)
                    )
                    FormFieldLabel(for: "tag_#{tag.id}") { tag.name.capitalize }
                  end
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

  private

  def alert_icon
    svg(
      class: "h-4 w-4",
      fill: "currentColor",
      viewBox: "0 0 24 24",
      xmlns: "http://www.w3.org/2000/svg"
    ) do |s|
      s.path(
        fill_rule: "evenodd",
        d: "M9.401 3.003c1.155-2 4.043-2 5.197 0l7.355 12.748c1.154 2-.29 4.5-2.599 4.5H4.645c-2.309 0-3.752-2.5-2.598-4.5L9.4 3.003zM12 8.25a.75.75 0 01.75.75v3.75a.75.75 0 01-1.5 0V9a.75.75 0 01.75-.75zm0 8.25a.75.75 0 100-1.5.75.75 0 000 1.5z",
        clip_rule: "evenodd"
      )
    end
  end
end
