class Answer < ApplicationRecord
    has_neighbors :embedding
    belongs_to :user
    belongs_to :question
    after_save :_set_embedding

    private

    def _set_embedding
        self.embedding = _embedding_for(text)
        self.save!
    end

    def _embedding_for(text)
        response = openai_client.embeddings(
          parameters: {
            model: 'text-embedding-ada-002',
            input: text
          }
        )
        puts "!!Get Embedding!!"
        response.dig('data', 0, 'embedding')
    end

    def openai_client
        @openai_client ||= OpenAI::Client.new
    end
end
