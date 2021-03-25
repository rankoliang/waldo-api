def attach_params(filename)
  {
    io: File.open(Rails.root.join('public/images', filename)),
    filename: filename,
    content_type: content_type(filename)
  }
end

def content_type(filename)
  case File.extname filename
  when 'jpg'
    'image/jpeg'
  when 'png'
    'image/png'
  end
end

department_store = Level.create({ title: 'Department Store' })

department_store.image.attach(
  attach_params('department-store.jpg')
)

department_store
  .characters.create(name: 'Waldo', shape: 'rect', coordinates: '1133,282,1215,399')
  .avatar.attach(attach_params('waldo-avatar.png'))

department_store
  .characters.create(name: 'Odlaw', shape: 'rect', coordinates: '521,1243,589,1357')
  .avatar.attach(attach_params('odlaw-avatar.jpg'))

department_store
  .characters.create(name: 'Wizard', shape: 'rect', coordinates: '1893,46,1957,130')
  .avatar.attach(attach_params('whitebeard-avatar.jpg'))
