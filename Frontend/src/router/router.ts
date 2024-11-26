import { createBrowserRouter } from "react-router-dom";

import { userRoutes } from "@router/routes";

import { homeRoutes } from "./routes/home";
import { signInRoutes } from "./routes/signIn";

export const router = createBrowserRouter([
  ...homeRoutes,
  ...signInRoutes,
  ...userRoutes,
]);
