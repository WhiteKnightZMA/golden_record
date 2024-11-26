import { type RouteObject } from "react-router-dom";
import { SignIn } from "@pages/SignIn";

export const signInRoutes: RouteObject[] = [
  {
    path: "/",
    element: <SignIn />,
  },
];
