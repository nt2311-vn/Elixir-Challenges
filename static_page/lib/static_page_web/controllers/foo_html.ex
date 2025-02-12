defmodule StaticPageWeb.FooHtml do
  use StaticPageWeb, :html

  embed_templates("templates/")
end
