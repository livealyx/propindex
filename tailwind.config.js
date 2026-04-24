/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./*.html", "./assets/js/**/*.js"],
  theme: {
    extend: {
      colors: {
        brand: {
          light: '#F8F9FA',
          dark: '#1A1A1A',
          accent: '#FF5A5F', // A humanized red-orange
          secondary: '#717171',
        },
        surface: {
          100: '#FFFFFF',
          200: '#F7F7F7',
          300: '#EBEBEB',
        }
      },
      borderRadius: {
        'pill': '9999px',
        'super': '2rem',
      },
      fontFamily: {
        sans: ['Inter', 'Outfit', 'sans-serif'],
      },
      animation: {
        'fade-in': 'fadeIn 0.5s ease-out forwards',
        'slide-up': 'slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { transform: 'translateY(20px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        }
      }
    },
  },
  plugins: [],
}
