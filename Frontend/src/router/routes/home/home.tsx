import { type RouteObject } from "react-router-dom";
import { Home } from "@pages/Home";
import { ProtectedRoute } from "@components/ProtectedRoute";

export const homeRoutes: RouteObject[] = [
  {
    path: "/",
    element: (
      <ProtectedRoute>
        <Home />
      </ProtectedRoute>
    ),
  },
];
