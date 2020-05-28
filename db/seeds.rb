user = User.create(
  name: 'hoge',
  email: 'email@email.com',
  password: 'password'
)

10.times do 
  Article.create(
    user: user,
    title: 'title',
    content: 'content'
  )
end
