import { FC } from "react";
import { LayoutProps } from "./types";

export const Layout: FC<LayoutProps> = ({
  children,
  backgroundColor,
  backgroundImage,
  header,
  footer,
}) => {
  return <div>{children}</div>;
};
