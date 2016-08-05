# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

local_path = "/Users/Kino/Development/YouxiaReview/yxReview/items.json"
records = JSON.parse(File.read(local_path))
records.each do |record|
  Review.create!(title: record['title'],
    cover_image: record['cover_image'],
    summary: record['summary'],
    score: record['score'])
end
