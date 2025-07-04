class Views::Shared::Pagination < Views::Base
  def initialize(pagination:, path: nil, **params)
    @pagination = pagination
    @path = path || :memos_path
    @params = params
  end

  def view_template
    return unless @pagination.total_pages > 1

    nav(class: "flex items-center justify-center space-x-2 mt-8") do
      # Previous buttons
      if @pagination.previous_page?
        Link(href: build_path(page: 1), variant: :outline, size: :sm) { "Primeira" }
        Link(href: build_path(page: @pagination.previous_page), variant: :outline, size: :sm) { "‹ Anterior" }
      else
        span(class: "px-3 py-2 text-sm text-gray-400 cursor-not-allowed") { "Primeira" }
        span(class: "px-3 py-2 text-sm text-gray-400 cursor-not-allowed") { "‹ Anterior" }
      end

      # Page info
      span(class: "px-4 py-2 text-sm font-medium text-gray-700") do
        "Página #{@pagination.page} de #{@pagination.total_pages}"
      end

      # Next buttons
      if @pagination.next_page?
        Link(href: build_path(page: @pagination.next_page), variant: :outline, size: :sm) { "Próxima ›" }
        Link(href: build_path(page: @pagination.total_pages), variant: :outline, size: :sm) { "Última" }
      else
        span(class: "px-3 py-2 text-sm text-gray-400 cursor-not-allowed") { "Próxima ›" }
        span(class: "px-3 py-2 text-sm text-gray-400 cursor-not-allowed") { "Última" }
      end
    end
  end

  private

  def build_path(page:)
    url_params = @params.merge(page: page)
    case @path
    when :memos_path
      memos_path(url_params)
    else
      send(@path, url_params)
    end
  end
end
