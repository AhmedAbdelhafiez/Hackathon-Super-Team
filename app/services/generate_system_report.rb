# frozen_string_literal: true

class GenerateSystemReport
  
    def initialize()
        user_id = User.system_user.id
        @report = prepare_report
        puts "Context to be Sent"
        puts @report
        IndexData.new(user_id, "System Data", @report).call
    end
  
    def call
      message_to_chat_api(<<~CONTENT)
        Summarize our Company performance by extracting the number of users that used our wizard
        Also the number of users that didn't continue with our wizard 
        Also the distribution of users around the world
        Based on context below
        Context: #{@report}
      CONTENT
    end
  
    private

    def prepare_report
        report = ""
        report+= "Number of users that accessed our website wizard #{users_count}\n"
        report+= users_progress
        report
    end

    def users_count
        User.count
    end

    def users_progress
        progress = ""
        User.all.each do |user|
            puts "!!!USER #{user.inspect}"
            if user && user.question_offset > 0
                question = Question.find(user.question_offset)
                progress+="User #{user.id} used our wizard in our company website\n"
                progress+="User #{user.id} stopped in this question: #{question.content}\n"
                progress+="User #{user.id} is located in #{user.country}\n"
            end
        end
        progress            
    end
  
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
  
  # GenerateSystemReport.new("Yours question..").call
  