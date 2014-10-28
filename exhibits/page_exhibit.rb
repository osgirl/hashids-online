class PageExhibit
  attr_reader :item, :context

  def initialize(item, context)
    @context, @item = context, item
  end

  def url
    context.url item.url
  end

  def display_name
    item.title
  end

  def name
    item.name
  end

  def menu_css_class(current_page)
    current_page.name == item.name ? 'active active-unlink' : ''
  end

  def render_menu
    context.erb :menu_item, locals: {menu_item: self}, views: context.settings.partials_dir
  end

  def render_page
    context.erb item.template, layout: :full_width,
        layout_options: {:views => context.settings.layouts_dir}
  end

  def render_with_sidebar
    context.erb item.template, layout: :with_sidebar,
        layout_options: {:views => context.settings.layouts_dir}
  end
end
#
