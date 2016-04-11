class StuffsDecorator < Draper::Decorator

  include Draper::LazyHelpers
  delegate_all

  def initialize(*args)
    @stuffs = object
    super
  end

  def filter_type_links
    Stuff.subclasses.map do |custom_stuff|
      active = @params[:filter_type] == custom_stuff.name
      link_to t("stuff.links.only_#{custom_stuff.name.tableize}"),
        @params.merge(filter_type: active ? nil : custom_stuff.name ),
        class: active ? :active : nil
    end
  end

  def for_showing
    apply_filters
    @stuffs
  end

  def with_params(params)
    @params = params
    self
  end

  def apply_filters
    @stuffs = 
      if @params[:filter_type]
        where type: @params[:filter_type]
      else
        where(nil)
      end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
