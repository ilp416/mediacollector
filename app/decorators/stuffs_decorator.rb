class StuffsDecorator < Draper::Decorator

  include Draper::LazyHelpers
  delegate_all

  Stuff.per_page = 30

  @stuff

  def initialize(relation)
    @stuffs = relation
    @params = {}
    super
  end

  def filter_type_links
    Stuff.subclasses_names.map do |stuff_type|
      active = @params[:filter_type] == stuff_type
      link_to t("stuff.links.only_#{stuff_type.underscore}_html"),
        @params.merge(filter_type: active ? nil : stuff_type),
        class: active ? :active : nil
    end
  end

  def for_showing
    apply_filters
    apply_search
    @stuffs.order(created_at: :desc).page @params[:page]
  end

  def paginate
    params = @params.merge(page: (@params[:page] || 1).to_i + 1)
    params.merge! append: true
    if for_showing.current_page < for_showing.total_pages 
      link_to t('stuff.load_more'), params, class: 'paginate button'
    end
  end

  def with_params(params = {})
    @params = params
    self
  end

  def apply_filters
    return unless @params[:filter_type]
    @stuffs = @stuffs.where type: @params[:filter_type]
  end

  def apply_search
    return unless @params[:search]
    @stuffs = 
      @stuffs.where "description LIKE ? OR target_url LIKE ?",
        "%#{@params[:search]}%",
        "%#{@params[:search]}%"
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
