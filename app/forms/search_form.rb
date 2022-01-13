class SearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :content, :string

  def search
    scope = Post.distinct
    scope = splited_bodies.map { |splited_content| scope.body_contain(splited_content) }.inject { |result, scp| result.or(scp) }
    if content.present?
      scope
    end
  end

  private

  def splited_bodies
    content.strip.split(/[[:blank:]]+/)
  end
end