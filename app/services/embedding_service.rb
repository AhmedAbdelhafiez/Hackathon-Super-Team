#frozen_string_literal

class EmbeddingService
    attr_reader :text

    def initialize(text)
        @text = text
    end

    def call()
        return _embedding_for(text) unless @text.nil?
    end
    
    private

    def _embedding_for(text)
        response = openai_client.embeddings(
            parameters: {
                model: 'text-embedding-ada-002',
                input: text
            }
        )
        response.dig('data', 0, 'embedding')
    end

    def openai_client
        @openai_client ||= OpenAI::Client.new
    end
end