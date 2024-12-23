import classNames from "classnames";
import { ButtonHTMLAttributes, FC } from "react";
import s from "./Button.module.css";

interface IButton extends ButtonHTMLAttributes<HTMLButtonElement> {
  size?: "M" | "L" | "XL";
  variant?: "primary-gold" | "primary-blue";
  fullWidth?: boolean;
  text?: string;
  className?: string;
}

export const Button: FC<IButton> = ({
  size = "M",
  variant = "primary-gold",
  fullWidth = false,
  text = "",
  className = "",
  ...props
}) => {
  return (
    <button
      className={classNames(
        className && className,
        s.button,
        variant && s[variant],
        fullWidth ? s["button-full"] : s[`button-${size.toLowerCase()}`]
      )}
      {...props}
    >
      {text && text}
    </button>
  );
};
