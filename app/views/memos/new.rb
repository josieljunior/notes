class Views::Memos::New < Views::Base
  def initialize(memo:, tags:)
    @memo = memo
    @tags = tags
  end

  def view_template
    div(class: "max-w-4xl mx-auto space-y-8") do
      div(class: "flex items-center space-x-2 text-sm text-gray-600") do
        link_to memos_path do
          Button(variant: :link, size: :sm) { "← Voltar para Memos" }
        end
      end

      div(class: "text-center space-y-4") do
        h1(class: "text-4xl font-bold text-gray-900") { "Criar Novo Memo" }
        p(class: "text-lg text-gray-600") { "Adicione um novo memo à sua coleção" }
      end

      render Views::Memos::Form.new(
        memo: @memo,
        tags: @tags,
        url: memos_path,
        method: :post
      )
    end
  end
end
