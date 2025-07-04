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
          p(class: "text-sm text-muted-foreground leading-relaxed") do
            @memo.content
          end

          if @memo.tags.any?
            div(class: "flex flex-wrap gap-2") do
              @memo.tags.each do |tag|
                span(class: "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200") do
                  "##{tag.name}"
                end
              end
            end
          end
        end
      end
    end
  end
end
