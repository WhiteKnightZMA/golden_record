import { FC } from "react";

import s from "./Header.module.css";
import { Logo } from "@components/Logo";

export const Header: FC = () => {
  return (
    <div className={s.header}>
      <Logo />
    </div>
  );
};
