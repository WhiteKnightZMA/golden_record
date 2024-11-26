import { FC } from "react";
import { PageLayoutProps } from "./types";

export const PageLayoutWithoutHeader: FC<PageLayoutProps> = ({ children }) => {
  return <div>{children}</div>;
};
