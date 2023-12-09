# frozen_string_literal: true
# Not Used !!!!!
class IndexDataService
    attr_reader :user_id
    attr_reader :page_name
    attr_reader :text

    def initialize(user_id, page_name, text)
        @openai_client = OpenAI::Client.new
        @user_id = user_id
        @page_name = page_name
        @text = text
    end
  
    def call
        old_item = Item.get_item(@page_name)
        if old_item.nil?
            embedding = EmbeddingService.new(question).call
            Item.create!(page_name: @page_name, text: @text, embedding: embedding, user_id: user_id)
            return 
        end
        old_item.append_text(@text)
        embedding = get_embedding(old_item.text)
        old_item.embedding = embedding
        old_item.save!
    end

    private
    
    def get_embedding(txt)
        response = @openai_client.embeddings(
            parameters: {
                model: 'text-embedding-ada-002',
                input: txt
            }
        )
        response.dig('data', 0, 'embedding')
    end
end