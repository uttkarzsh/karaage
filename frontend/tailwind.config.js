/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{ts,tsx}"],
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        karaageBg: "#FBE7B4",
        karaageBrown: "#A45B24",
        karaageAccent: "#F0983E",
      },
      fontFamily: {
        serif: ['Merriweather', 'serif'],
      }
    }
  },
  plugins: [],
};
