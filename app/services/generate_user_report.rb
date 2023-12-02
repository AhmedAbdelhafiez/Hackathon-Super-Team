# frozen_string_literal: true

class GenerateUserReport
    attr_reader :user_id
  
    def initialize(user_id)
        @user_data = Item.get_user_context(user_id).text
        puts "User Data !!! #{@user_data}!!!"
    end
  
    def call
      message_to_chat_api(<<~CONTENT)
        Summarize a user request to build a software product by listing the following data in this format
        { 
          main_idea: "", 
          requirements: "",
          project_size: "",
          budget: "",
          time_duration: ""
        }
        Based on context below
        Context: #{@user_data}
      CONTENT
    end
  
    private
  
    def message_to_chat_api(message_content)
      response = openai_client.chat(parameters: {
        model: 'gpt-3.5-turbo-1106',
        messages: [{ role: 'user', content: message_content }],
        temperature: 0.5
      })
      response.dig('choices', 0, 'message', 'content')
    end
      
    def openai_client
      @openai_client ||= OpenAI::Client.new
    end
  end
  
  # GenerateReport.new("Yours question..").call
  