class Views::Shared::Pagination < Views::Base
  def initialize(pagination:, path: nil, **params)
    @pagination = pagination
    @path = path
    @params = params
  end

  def view_template
    return unless @pagination.total_pages > 1

    Pagination do
      PaginationContent do
        if @pagination.previous_page?
          PaginationItem(href: build_path(page: 1)) do
            chevron_left_icon
            plain "Primeira"
          end
          PaginationItem(href: build_path(page: @pagination.previous_page)) do
            chevron_left_icon
            plain "Anterior"
          end
        end

        render_page_numbers

        if @pagination.next_page?
          PaginationItem(href: build_path(page: @pagination.next_page)) do
            plain "Próxima"
            chevron_right_icon
          end
          PaginationItem(href: build_path(page: @pagination.total_pages)) do
            plain "Última"
            chevron_right_icon
          end
        end
      end
    end
  end

  private

  def chevron_left_icon
    svg(xmlns: "http://www.w3.org/2000/svg", width: "24", height: "24", viewBox: "0 0 24 24", "stroke-width": "1.5", stroke: "currentColor", fill: "none", "stroke-linecap": "round", "stroke-linejoin": "round", class: "h-4 w-4") do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(d: "M15 6l-6 6l6 6")
    end
  end

  def chevron_right_icon
    svg(xmlns: "http://www.w3.org/2000/svg", width: "24", height: "24", viewBox: "0 0 24 24", "stroke-width": "1.5", stroke: "currentColor", fill: "none", "stroke-linecap": "round", "stroke-linejoin": "round", class: "h-4 w-4") do |s|
      s.path(stroke: "none", d: "M0 0h24v24H0z", fill: "none")
      s.path(d: "M9 6l6 6l-6 6")
    end
  end

  def build_path(page:)
    url_params = @params.merge(page: page)
    case @path
    when :memos_path
      memos_path(url_params)
    else
      send(@path, url_params)
    end
  end

  def render_page_numbers
    current_page = @pagination.page
    total_pages = @pagination.total_pages

    start_page = [ 1, current_page - 2 ].max
    end_page = [ total_pages, current_page + 2 ].min

    (start_page..end_page).each do |page|
      PaginationItem(href: build_path(page: page), active: page == current_page) { page.to_s }
    end
  end
end
