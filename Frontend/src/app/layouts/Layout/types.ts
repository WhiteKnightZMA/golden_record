import { ReactNode } from "react";

export interface LayoutProps {
  backgroundImage?: string;
  backgroundColor?: string;
  children: ReactNode;
  header?: JSX.Element;
  footer?: JSX.Element;
}
