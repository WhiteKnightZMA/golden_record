import { RouterProvider } from "react-router-dom";
import { router } from "@/router";
import "@styles/App.css";
import { FC } from "react";

export const App: FC = () => {
  return <RouterProvider router={router} />;
};
