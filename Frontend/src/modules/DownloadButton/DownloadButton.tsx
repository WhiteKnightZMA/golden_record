import { Button } from "@/shared/ui/Button";
import { ButtonHTMLAttributes, FC } from "react";

interface IDownloadButton extends ButtonHTMLAttributes<HTMLButtonElement> {
  className?: string;
  link?: Blob;
}

export const DownloadButton: FC<IDownloadButton> = ({
  className = "",
  link,
  ...props
}) => {
  return (
    <>
      <Button
        onClick={(e) => e.preventDefault()}
        type="button"
        text="Скачать файлы"
        variant="primary-blue"
        size="XL"
        {...props}
        className={className}
      />
    </>
  );
};
