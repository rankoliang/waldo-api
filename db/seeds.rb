department_store = Level.create({ title: 'Department Store' })
department_store.image.attach(
  io: File.open(Rails.root.join('public/images/department-store.jpg')),
  filename: 'department_store.jpg',
  content_type: 'image/jpeg'
)
