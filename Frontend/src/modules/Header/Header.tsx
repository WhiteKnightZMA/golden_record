import { FC } from "react";
import s from "./Header.module.css";
import { Logo } from "@components/Logo";
import { showFormStore } from "@/store/showForm";

export const Header: FC = () => {
  return (
    <div className={s.header} onClick={() => showFormStore.showForm()}>
      <Logo />
    </div>
  );
};
