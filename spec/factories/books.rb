FactoryBot.define do
  factory :book do

    title       { "The Great Gatsby" }
    author      { "F. Scott Fitzgerald" }
    description { "A story of the Jazz Age." }
    price       { 10.99 }

    association :user
    
  end
end
