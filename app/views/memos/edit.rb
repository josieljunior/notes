class Views::Memos::Edit < Views::Base
  def initialize(memo:, tags:)
    @memo = memo
    @tags = tags
  end

  def view_template
    div(class: "max-w-4xl mx-auto space-y-8") do
      div(class: "flex items-center space-x-2 text-sm text-gray-600") do
        Link(href: memo_path(@memo), variant: :link, size: :sm) { "← Voltar para Nota" }
      end

      div(class: "text-center space-y-4") do
        h1(class: "text-4xl font-bold text-gray-900") { "Editar Nota" }
        p(class: "text-lg text-gray-600") { "Faça as alterações necessárias na sua nota" }
      end

      render Views::Memos::Form.new(
        memo: @memo,
        tags: @tags,
        url: memo_path(@memo),
        method: :patch
      )
    end
  end
end
