# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create!([{ email: 'nick@example.com', password: 'qwerty123' },
                      { password: 'qwerty123', email: 'john@example.com' }])
questions = Question.create!(
  [
    { title: 'HTML', body: 'What does HTML stand for?', user: users[0] },
    { title: 'HTML', body: 'Who is making the Web standards?', user: users[0] },
    { title: 'HTML', body: 'Choose the correct HTML element for the largest heading:', user: users[1] },
    { title: 'HTML', body: 'What is a correct syntax to output "Hello World" in Python?', user: users[1] },
    { title: 'Python', body: 'How do you insert COMMENTS in Python code?', user: users[0] },
    { title: 'SQL', body: 'What does SQL stand for?', user: users[0] }
  ]
)
answers = Answer.create!(
  [
    { body: 'Hyper Text Markup Language', question: questions[0], user: users[0] },
    { body: 'Home Tool Markup Language', question: questions[0], user: users[0] },
    { body: 'Hyperlinks and Text Markup Language', question: questions[0], user: users[0] },
    { body: 'Google', question: questions[1], user: users[0] },
    { body: 'Mozilla', question: questions[1], user: users[0] },
    { body: 'The World Wide Web Consortium', question: questions[1], user: users[0] },
    { body: 'Microsoft', question: questions[1], user: users[0] },
    { body: '<h6>', question: questions[2], user: users[1] },
    { body: '<heading>', question: questions[2], user: users[1] },
    { body: 'p("Hello World")', question: questions[3], user: users[0] },
    { body: 'echo("Hello World")', question: questions[3], user: users[0] },
    { body: 'print("Hello World")', question: questions[3], user: users[1] },
    { body: 'Hecho "Hello World"', question: questions[3], user: users[1] }
  ]
)
