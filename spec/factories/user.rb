# frozen_string_literal: false

FactoryBot.define do
  factory :user do
    access_token { Faker::Number.number }
    git_id { Faker::Number.number(digits: 4) }
    login { Faker::Name.name }
    avatar_url { Faker::Name.name }
    url { Faker::Name.name }
    repos_url { Faker::Name.name }
    organisations_url { Faker::Name.name }
    repositories { [Faker::Name.name] }
    received_events_url { Faker::Name.name }
    company { Faker::Name.name }
    name { Faker::Name.name }
    blog { Faker::Name.name }
    location { Faker::Name.name }
    email { Faker::Name.name }
    bio { Faker::Name.name }
    github_account_created_at { Faker::Name.name }
    twitter_username { Faker::Name.name }
  end
end
