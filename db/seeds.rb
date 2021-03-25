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

def waldo(shape: 'rect', coordinates:)
  {
    name: 'Waldo',
    avatar: waldo_avatar,
    shape: shape,
    coordinates: coordinates
  }
end

def odlaw(shape: 'rect', coordinates:)
  {
    name: 'Odlaw',
    avatar: odlaw_avatar,
    shape: shape,
    coordinates: coordinates
  }
end

def wizard(shape: 'rect', coordinates:)
  {
    name: 'Wizard',
    avatar: wizard_avatar,
    shape: shape,
    coordinates: coordinates
  }
end

levels = [
  {
    title: 'Department Store',
    image_filename: 'department-store.jpg',
    characters: [
      waldo(coordinates: '1133,282,1215,399'),
      odlaw(coordinates: '521,1243,589,1357'),
      wizard(coordinates: '1893,46,1957,130')
    ]
  },
  {
    title: 'The Unfriendly Giants',
    image_filename: 'the-unfriendly-giants.jpeg',
    characters: [
      waldo(coordinates: '601,1449,668,1557'),
      odlaw(coordinates: '2056,1997,2124,2085'),
      wizard(coordinates: '3386,1694,3438,1780')
    ]
  },
  {
    title: 'The Deep-Sea Divers',
    image_filename: 'the-deep-sea-divers.jpeg',
    characters: [
      waldo(coordinates: '2322,340,2390,446'),
      odlaw(coordinates: '1038,410,1094,525'),
      wizard(coordinates: '2752,260,2796,336')
    ]
  },
  {
    title: 'When the Stars come out',
    image_filename: 'when-the-stars-come-out.jpeg',
    characters: [
      waldo(coordinates: '2505,890,2566,995'),
      odlaw(coordinates: '1950,1779,2018,1876'),
      wizard(coordinates: '2449,1470,2530,1593')
    ]

  }
]

levels.each do |level_info|
  level = Level.create(title: level_info[:title])

  level.image.attach(
    attach_params(level_info[:image_filename])
  )

  next unless level_info[:characters]

  level_info[:characters].each do |character|
    level
      .characters.create(character.slice(:name, :shape, :coordinates))
      .avatar.attach(character[:avatar])
  end
end
