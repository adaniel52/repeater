int getJuz(int page) {
  int temp = ((page - 1) / 20).ceil();
  return (temp < 1) ? 1 : (temp > 30 ? 30 : temp);
}

const notes = [
  {
    'imageUrl':
        'https://github.com/adaniel52/repeater/blob/app/assets/nun-sakinah.png?raw=true',
    'title': 'Nun Sakinah',
    'subtitle':
        'Lorem ipsum dolor sit adapibus felis. Lorem ipsuus felis. Lorem ipsum dolor sit adapibus felis.',
  },
  {
    'imageUrl':
        'https://github.com/adaniel52/repeater/blob/app/assets/mim-sakinah.png?raw=true',
    'title': 'Mim Sakinah',
    'subtitle': 'Lorem ipsum dolor sit adapibus felis.',
  },
  {
    'imageUrl':
        'https://github.com/adaniel52/repeater/blob/app/assets/nun-sakinah.png?raw=true',
    'title': 'Nun Sakinah',
    'subtitle':
        'Lorem ipsum dolor sit adapibus felis. Lorem ipsuus felis. Lorem ipsum dolor sit adapibus felis.',
  },
  {
    'imageUrl':
        'https://github.com/adaniel52/repeater/blob/app/assets/mim-sakinah.png?raw=true',
    'title': 'Mim Sakinah',
    'subtitle': 'Lorem ipsum dolor sit adapibus felis.',
  },
  {
    'imageUrl':
        'https://github.com/adaniel52/repeater/blob/app/assets/nun-sakinah.png?raw=true',
    'title': 'Nun Sakinah',
    'subtitle':
        'Lorem ipsum dolor sit adapibus felis. Lorem ipsuus felis. Lorem ipsum dolor sit adapibus felis.',
  },
  {
    'imageUrl':
        'https://github.com/adaniel52/repeater/blob/app/assets/mim-sakinah.png?raw=true',
    'title': 'Mim Sakinah',
    'subtitle':
        'Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. Lorem ipsum dolor sit adapibus felis. ',
  },
];
