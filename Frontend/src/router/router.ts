import { createBrowserRouter } from "react-router-dom";
import { homeRoutes } from "./routes/home";
import { notFoundRoute } from "./routes/notFound";

export const router = createBrowserRouter([ ...homeRoutes, ...notFoundRoute]);
