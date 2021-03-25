# helpers

def attach_params(filename)
  {
    io: File.open(Rails.root.join('public/images', filename)),
    filename: filename,
    content_type: content_type(filename)
  }
end

def content_type(filename)
  case File.extname filename
  when 'jpg', 'jpeg'
    'image/jpeg'
  when 'png'
    'image/png'
  end
end

# avatars

def waldo_avatar
  attach_params('waldo-avatar.png')
end

def odlaw_avatar
  attach_params('odlaw-avatar.png')
end

def wizard_avatar
  attach_params('whitebeard-avatar.png')
end

# characters

waldo = Character.create(name: 'Waldo')
waldo.avatar.attach(waldo_avatar)

odlaw = Character.create(name: 'Odlaw')
odlaw.avatar.attach(odlaw_avatar)

wizard = Character.create(name: 'Wizard')
wizard.avatar.attach(wizard_avatar)

# levels

levels = [
  {
    title: 'Department Store',
    image_filename: 'department-store.jpg',
    search_areas: [
      { shape: 'rect', coordinates: '1133,282,1215,399', character: waldo },
      { shape: 'rect', coordinates: '521,1243,589,1357', character: odlaw },
      { shape: 'rect', coordinates: '1893,46,1957,130', character: wizard }
    ]
  },
  {
    title: 'The Unfriendly Giants',
    image_filename: 'the-unfriendly-giants.jpeg',
    search_areas: [
      { shape: 'rect', coordinates: '601,1449,668,1557', character: waldo },
      { shape: 'rect', coordinates: '2056,1997,2124,2085', character: odlaw },
      { shape: 'rect', coordinates: '3386,1694,3438,1780', character: wizard }
    ]
  },
  {
    title: 'The Deep-Sea Divers',
    image_filename: 'the-deep-sea-divers.jpeg',
    search_areas: [
      { shape: 'rect', coordinates: '2322,340,2390,446', character: waldo },
      { shape: 'rect', coordinates: '1038,410,1094,525', character: odlaw },
      { shape: 'rect', coordinates: '2752,260,2796,336', character: wizard }
    ]
  },
  {
    title: 'When the Stars come out',
    image_filename: 'when-the-stars-come-out.jpeg',
    search_areas: [
      { shape: 'rect', coordinates: '2505,890,2566,995', character: waldo },
      { shape: 'rect', coordinates: '1950,1779,2018,1876', character: odlaw },
      { shape: 'rect', coordinates: '2449,1470,2530,1593', character: wizard }
    ]
  }
]

levels.each do |level_info|
  level = Level.create(title: level_info[:title])

  level.image.attach(
    attach_params(level_info[:image_filename])
  )

  next unless level_info[:search_areas]

  level_info[:search_areas].each do |search_area|
    level.search_areas.create(search_area)
  end
end
