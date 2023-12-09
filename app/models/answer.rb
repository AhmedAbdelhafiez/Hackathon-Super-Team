class Answer < ApplicationRecord
  has_neighbors :embedding
  belongs_to :user
  belongs_to :question
  before_save :_set_embedding
  after_save :_increment_offset

  private

  def _set_embedding
      self.embedding = EmbeddingService.new(self.text).call
  end

  def _increment_offset
    self.user.increment_offset
  end
end
