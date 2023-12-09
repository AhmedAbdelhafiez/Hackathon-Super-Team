DATA = [
  [
    "Livy Method",
    "Trianglz is a software company that has a product called Livy Method, The Livy product is a 12-week weight loss app with a 91-day program. Users log daily meals, track progress, and access videos, posts, and guides on nutrition and exercises. Each week has a theme, ending with a motivational summary. After completing the program, users enter a maintenance period. They can communicate with mentors and connect with a community. The app's MVP features include daily logging, curated posts, weekly guides, progress tracking, social media sharing, and before-and-after photos. The program lasts for 6 months. Video Demo: https://drive.google.com/file/d/1WEJvGoN_qAx-rnD1TR4LgQjIFs86d1FW/view",
    "https://drive.google.com/file/d/1WEJvGoN_qAx-rnD1TR4LgQjIFs86d1FW/view"
  ],
  [
    "Mimar",
    "Trianglz is a software company that has a product called mimar \nDescription: Mimar helps you to book your appointments anytime, anywhere. You can browse for nearby providers with various categories such as beauty, health or wellness. You can check their availability, their staff, as well as checking what others said about them.\nNo need for picking up the phone, your appointment is only a few clicks away and our reminders will also make sure you never miss an appointment. Video Demo: https://drive.google.com/file/d/1pSJ7vWRx_Ayy73qYhdoCdKNrnP0mgrEK/view",
    "https://drive.google.com/file/d/1pSJ7vWRx_Ayy73qYhdoCdKNrnP0mgrEK/view"
  ],
  [
    "Tiro",
    "Tiro is a user-friendly online food app that makes ordering from favorite stores easy. Customers can choose products, pick pickup or dine-in, and pay securely online or with cash. For stores, Tiro is a handy management tool, letting them showcase products, manage branches and inventory, and track orders in real-time. In 8 months, Tiro added cool features like a user-friendly interface, a shopping cart for smooth shopping, and easy order placement and tracking. Tiro is all about making online food ordering simple and empowering for both customers and stores.",
    "Tiro Video"
  ],
  [
    "Kuzlo",
    "Kuzlo is a convenient wholesale marketplace tailored for retailers in the food and supermarket business. In just 7 months, it introduced key features like easy account creation, a search function for detailed product info, and the ability to add items to your cart. At checkout, users have the flexibility to pay for the entire order or choose specific products or wholesalers to pay for. Kuzlo's location-based feature helps users find nearby wholesalers based on their specified area. Plus, it keeps users in the loop with notifications about discounts, changes, and order details. It's all about making wholesale purchases hassle-free and keeping users informed every step of the way.",
    "Kuzlo Video"
  ],
  [
    "3elagi",
    "3elagi is a user-friendly app designed to simplify the prescription process, making it hassle-free for both individuals and pharmacies. In just 6 months, the app has introduced features like an easy-to-use interface for prescription submission, geolocation-based identification of nearby pharmacies, and a direct communication channel between clients and pharmacies. The streamlined prescription fulfillment process enhances convenience for users, while optimization tools empower pharmacies to manage and fulfill prescriptions efficiently. 3elagi's comprehensive system is dedicated to ensuring a seamless experience for both clients and pharmacies, making the process of obtaining prescriptions smoother and more accessible for everyone involved.",
    "3elagi Video"
  ],
  [
    "Technie",
    "Techne is a specialized app designed for the annual Techne Summit in Cairo and Alexandria, offering a streamlined approach to attendee management over a 3-month period. The app categorizes attendees as regular participants or speakers, providing a unique QR code for effortless event entry. It features event sponsors, speakers, and a schedule of conferences and workshops that attendees can filter by day and time. Attendees can personalize their experience by creating wishlists, receive timely event reminders, explore other attendee profiles, and engage in real-time conversations through the chat feature, fostering a more connected and interactive event environment. Techne aims to enhance the overall event experience by simplifying attendee interactions and event navigation.",
    "Technie Video"
  ],
  [
    "Seater",
    "Seater, a student transportation app, simplifies the process for parents by allowing them to choose their child's school and input details, presenting a list of available rides to the same destination with various car types and prices over a 4-month period. Parents can select the most suitable option and make payments online or offline. The app provides the added convenience of tracking their child's journey, ensuring they reach school safely or are still in transit. Additionally, parents can mark their child as absent for a day, notifying the organization and avoiding unnecessary wait times. On the administrative side, the app enables administrators to create trip listings, designate available areas, track assigned vehicles, add new schools to the system, and manually create payments for individual children, contributing to a comprehensive and efficient student transportation solution.",
    "Seater Video"
  ]
  # ...
]

desc 'Fills database with data and calculate embeddings for each item.'
task index_data: :environment do
  openai_client = OpenAI::Client.new

  DATA.each do |item|
    page_name, text, media = item

    response = openai_client.embeddings(
      parameters: {
        model: 'text-embedding-ada-002',
        input: text
      }
    )

    embedding = response.dig('data', 0, 'embedding')

    Item.create!(page_name: page_name, text: text, embedding: embedding, media: media, user_id: User.first.id)

    puts "Data for #{page_name} created!"
    sleep 30
  end
end
