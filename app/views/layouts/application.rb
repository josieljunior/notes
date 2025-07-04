module Views
  module Layouts
    class Application < Views::Base
      include Phlex::Rails::Layout

      def view_template(&block)
        doctype

        html do
          head do
            title { "Melhores Corretoras de Investimento" }

            meta name: "viewport", content: "width=device-width,initial-scale=1"
            meta name: "apple-mobile-web-app-capable", content: "yes"
            meta name: "mobile-web-app-capable", content: "yes"

            # CSRF e CSP tags
            csrf_meta_tags
            csp_meta_tag

            # Ícones
            link rel: "icon", href: "/icon.png", type: "image/png"
            link rel: "icon", href: "/icon.svg", type: "image/svg+xml"
            link rel: "apple-touch-icon", href: "/icon.png"

            # Stylesheets e JavaScript
            stylesheet_link_tag(:app, "data-turbo-track": "reload")
            javascript_importmap_tags
          end

          body do
            # render Shared::Navbar.new
            main(class: "container mx-auto mt-28 px-5 flex", &block)
          end
        end
      end
    end
  end
end
