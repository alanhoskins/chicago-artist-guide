/** @type {import('tailwindcss').Config} */
import type { Config } from "tailwindcss";

const config = {
  darkMode: ["class"],
  content: [
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  prefix: "",
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      colors: {
        banana: "#F9E9B1",
        blush: "#F7BEB2",
        butter: "#EFC93D",
        fog: "#F3F5FB",
        light: "#D4D6DF",
        dark: "#3B4448",
        midnight: "#0C2028",
        gold: "#F5AF19",
        salmon: "#E17B60",
        mint: "#82B29A",
        slate: "#2F4550",
        rust: "#995E4F",
        evergreen: "#4A725D",
        cornflower: "#537C8C",
        yoda: "#B8D8C7",
        sky: "#A3C2CC",
        current: "currentColor",
        transparent: "transparent",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        btn: {
          background: "hsl(var(--btn-background))",
          "background-hover": "hsl(var(--btn-background-hover))",
        },
      },
      fontFamily: {
        sans: ["Montserrat", "sans-serif"],
        serif: ["Lora", "serif"],
        main: ['"Open Sans"', "sans-serif"],
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
} satisfies Config;

export default config;
