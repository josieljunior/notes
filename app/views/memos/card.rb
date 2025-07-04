class Views::Memos::Card < Views::Base
  def initialize(memo)
    @memo = memo
  end

  def view_template
    Card(class: "w-full h-full flex flex-col") do
      CardHeader do
        CardTitle { @memo.title }
      end

      CardContent(class: "flex-1") do
        div(class: "space-y-3") do
          div(class: "max-h-32 overflow-hidden") do
            p(class: "text-sm text-muted-foreground leading-relaxed whitespace-pre-wrap") do
              @memo.content
            end
          end

          if @memo.tags.any?
            div(class: "flex flex-wrap gap-2") do
              @memo.tags.each do |tag|
                Badge(variant: :primary, size: :sm) { "#{tag.name}" }
              end
            end
          end
        end
      end
    end
  end
end
