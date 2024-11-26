import { createBrowserRouter } from "react-router-dom";
import { homeRoutes } from "./routes/home";

export const router = createBrowserRouter([
  ...homeRoutes,
]);
