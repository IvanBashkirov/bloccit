# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

require 'random_data'

50.times do
  Post.create!(
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end

unique_post = Post.find_or_create_by!(title: "Unique Title", body: "Unique body");

posts = Post.all

100.times do
  Comment.create!(
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

Comment.find_or_create_by!(post: unique_post, body: "Unique body");

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
