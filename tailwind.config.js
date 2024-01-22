const colors = require('tailwindcss/colors')
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.{js, jsx, vue}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter", "sans-serif",'Poppins'],
        'lato': ['Lato', 'sans-serif'],
        'lilita': ['Lilita One', 'cursive']
      },
      colors : {
        cyan: colors.cyan,
        gray : {
          50: '#F9FAFB',
          100 : '#E0E6E9',
          300: '#F1F1F1',
          400: '#E0E0E0',
          500: '#AEAEAE',
          600: '#7E7E7E',
          700: '#393C49',
          800: '#252836',
          900: '#303030',
        },
        blue : {
          500 : '#1976D2',
          600 : '#0C63D4',
        },
        teal : {
          500 : '#40B2B7',
          600 : '#188F95',
        },
        orange : {
          500 : '#F4694C',
          600 : '#ee5c3e',
        },
        primary : '#EB966A',
        accent : {
          blue: '#65B0F6',
          orange: '#FFB572',
          red: '#FF7CA3',
          green: '#50D1AA',
          purple : '#9290FE'
        },
        'gunmetal': "#1b232c",
        'flash-white': "#f4f5f8",
        'slate-grey': '#808997',
        'light-white': '#FAFCFF',
        'medium-blue': '#3026B9',
        'davy-grey': '#4A4E55',
        'persian-rose': '#FC2EB0',
        'brown': '#90722C',
        'light-brown': '#FCF2D9',
        'green': '#2E6638',
        'light-green': '#DCEEDE',
        'blue': '#101749',
        'light-blue': '#EAE8F7',
        'purple': '#7A4C7A',
        'light-purple': '#FCE9FC',
        'pine-green': '#19746A',
        'light-pine-green': '#E7FBF9',
        'pigment-green': '#4DAA5D'
      },
      spacing : {
        '4.5' : '1.125rem',
      },
      boxShadow : {
        lg : '0px 5px 14px rgba(244, 105, 76, 0.25)',
        primary : '0px 8px 24px rgba(234, 124, 105, 0.32)',
        'inverse-top' : '4px 4px 0 #252836',
        'inverse-bottom' : '4px -4px 0 #252836',
        'tab-item': 'rgba(0, 0, 0, 0.1) 0px 3px 5px',
        'tab-item-hover': 'rgba(0, 0, 0, 0.2) 0px 3px 8px',
        'nav': 'rgba(100, 100, 111, 0.2) 0px 7px 29px 0px'
      },
      screens: {
        'xs': '420px',
        'sm': '576px',
        'md': '768px',
        'lg': '992px',
        'xl': '1200px',
        'xxl': '1400px'
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/line-clamp'),
  ]
}
