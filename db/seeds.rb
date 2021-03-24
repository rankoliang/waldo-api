department_store = Level.create({ title: 'Department Store' })
department_store.image.attach(
  io: File.open(Rails.root.join('public/images/department-store.jpg')),
  filename: 'department_store.jpg',
  content_type: 'image/jpeg'
)
department_store.characters.create(name: 'Waldo', shape: 'rect', coordinates: '1133,282,1215,399')
department_store.characters.create(name: 'Odlaw', shape: 'rect', coordinates: '521,1243,589,1357')
department_store.characters.create(name: 'Wizard', shape: 'rect', coordinates: '1893,46,1957,130')

50.times do
  department_store.scores.create(name: 'Anonymous', milliseconds: rand(1000..100_000))
end
