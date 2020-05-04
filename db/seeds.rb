# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.delete_all
Comment.delete_all
User.delete_all

user = User.all

PASSWORD = 'supersecret'
super_user = User.create(
    name: 'jon',
    email: 'js@winterfell.gov',
    password: PASSWORD
)
10.times do 
    created_at = Faker::Date.backward(days: 365 * 5)
    User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: PASSWORD  
    )
end

100.times do
    p = Post.create(
        title: Faker::Book.title,
        body: Faker::ChuckNorris.fact
    )

    if p.valid? 
        p.comments = rand(0..15).times.map do 
            Comment.new(
                body: Faker::GreekPhilosophers.quote
            
            )
        end
    end
end

post = Post.all
comment = Comment.all

puts Cowsay.say("Generated #{post.count} posts", :cow)
puts Cowsay.say("Generated #{comment.count} comments", :frogs)
puts Cowsay.say("Generated #{user.count} users", :dragon)