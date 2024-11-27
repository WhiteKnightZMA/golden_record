import { FC, useEffect, useRef, useState } from "react";
import { useForm } from "react-hook-form";
import s from "./Form.module.css";
import { ChooseButton } from "../../ChooseButton/ChooseButton";
import cloudIcon from "@assets/icons/cloud.svg";
import { ConfirmFiles } from "../../ConfirmFiles/ui/ConfirmFiles";

interface IForm {
  files: FileList | null;
}

export const Form: FC = () => {
  const [isFilesUploaded, setIsFilesUploaded] = useState<boolean>(false);

  const { handleSubmit, register, watch, setValue } = useForm<IForm>();

  const onSubmit = (data) => {
    console.log(data);
  };

  const files = watch("files");

  useEffect(() => {
    if (!files) return;
    if (files.length > 3) {
      alert("Вы можете загрузить не более 3 файлов");
      setValue("files", null);
    } else {
      let allFilesValid: boolean = true;
      for (const file of files) {
        if (file.type !== "text/csv") {
          alert("Вы можете загрузить только .scv файлы");
          setValue("files", null);
          allFilesValid = false;
          break;
        }
      }
      if (allFilesValid) {
        setIsFilesUploaded(true);
      }
    }
  }, [files, setValue]);

  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleButtonClick = () => {
    fileInputRef.current?.click();
  };

  return (
    <form className={s.form} onSubmit={handleSubmit(onSubmit)}>
      {isFilesUploaded ? (
        <ConfirmFiles
          files={files}
          onSubmit={onSubmit}
          onCancel={() => setIsFilesUploaded(false)}
        />
      ) : (
        <>
          <img src={cloudIcon} alt="Cloud" />
          <p className={s.text}>
            Перетащите .csv файлы сюда, чтобы получить золотую запись
          </p>
          <input
            {...register("files")}
            className={s.input}
            type="file"
            accept=".csv"
            multiple
          />
          <ChooseButton
            className={s.chooseButton}
            onClick={handleButtonClick}
          />
        </>
      )}
    </form>
  );
};
