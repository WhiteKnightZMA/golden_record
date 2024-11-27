import { FC } from "react";
import s from "./Header.module.css";
import { Logo } from "@components/Logo";
import { showFormStore } from "@/store/showForm";
import { useScreenSize } from "@/shared/hooks/useScreenSize";

export const Header: FC = () => {
  const { isLaptop, isDesktop } = useScreenSize();

  return (
    <div className={s.header} onClick={() => showFormStore.showForm()}>
      <Logo style={{ width: !isDesktop ? "180px" : "220px" }} />
    </div>
  );
};
