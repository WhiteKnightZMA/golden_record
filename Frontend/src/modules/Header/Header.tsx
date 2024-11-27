import { FC } from "react";
import s from "./Header.module.css";
import { Logo } from "@components/Logo";
import { useNavigate } from "react-router-dom";

export const Header: FC = () => {
  const navigate = useNavigate();
  return (
    <div className={s.header} onClick={() => navigate("/")}>
      <Logo />
    </div>
  );
};
