import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { resolve } from "path";

// https://vitejs.dev/config/
export default defineConfig({
  resolve: {
    alias: {
      "@app": resolve(__dirname, "src/app"),
      "@layouts": resolve(__dirname, "src/layouts"),
      "@modules": resolve(__dirname, "src/modules"),
      "@pages": resolve(__dirname, "src/pages"),
      "@router": resolve(__dirname, "src/router"),
      "@shared": resolve(__dirname, "src/shared"),
      "@hooks": resolve(__dirname, "src/shared/hooks"),
      "@compnents": resolve(__dirname, "src/shared/compnents"),
      "@assets": resolve(__dirname, "src/shared/assets"),
      "@ui": resolve(__dirname, "src/shared/ui"),
    },
  },
  plugins: [react()],
});
