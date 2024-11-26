import { FC } from "react";
import { Layout } from "../Layout";
import { PageLayoutProps } from "./types";
import { Header } from "@/modules/Header";

export const PageLayout: FC<PageLayoutProps> = ({ children, ...props }) => {
  return (
    <Layout {...props} header={<Header />}>
      {children}
    </Layout>
  );
};
