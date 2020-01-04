# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'colorize'

ActiveRecord::Base.transaction do 
  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean

  puts "Creating users...".red
  User.destroy_all
  user1 = User.create(username: 'user1', password: 'password')
  user2 = User.create(username: 'user2', password: 'password')
  user3 = User.create(username: 'user3', password: 'password')

  puts "Creating subs...".yellow
  Sub.destroy_all
  sub1 = Sub.create(title: 'sub1', description: 'desc...', mod_id: user1.id)
  sub2 = Sub.create(title: 'sub2', description: 'desc...', mod_id: user1.id)
  sub3 = Sub.create(title: 'sub3', description: 'desc...', mod_id: user1.id)
  sub4 = Sub.create(title: 'sub4', description: 'desc...', mod_id: user2.id)

  puts "Deleting post subs...".green
  PostSub.destroy_all

  puts "Creating posts...".light_blue
  Post.destroy_all
  post1 = Post.create(title: 'post1', url: 'url.com', content: 'content...', author_id: user1.id, sub_ids: [sub1.id])
  post2 = Post.create(title: 'post2', url: 'url.com', content: 'content...', author_id: user1.id, sub_ids: [sub1.id])
  post3 = Post.create(title: 'post3', url: 'url.com', content: 'content...', author_id: user1.id, sub_ids: [sub1.id])
  post4 = Post.create(title: 'post4', url: 'url.com', content: 'content...', author_id: user2.id, sub_ids: [sub2.id])

  puts "Creating comments...".blue
  Comment.destroy_all
  comment1 = Comment.create(
    content: 'comment1', 
    post_id: post1.id, 
    author_id: user1.id,
    parent_comment_id: nil
  )

  comment2 = Comment.create(
    content: 'comment2', 
    post_id: post1.id, 
    author_id: user1.id,
    parent_comment_id: comment1.id
  )

  comment3 = Comment.create(
    content: 'comment3', 
    post_id: post1.id, 
    author_id: user1.id,
    parent_comment_id: comment2.id
  )

  comment4 = Comment.create(
    content: 'comment4', 
    post_id: post2.id, 
    author_id: user2.id,
    parent_comment_id: nil
  )


  puts "Success!".magenta
end