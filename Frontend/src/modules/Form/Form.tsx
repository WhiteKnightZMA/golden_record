import { FC, useRef } from "react";
import { useForm } from "react-hook-form";
import s from "./Form.module.css";
import { ChooseButton } from "../ChooseButton/ChooseButton";
import cloudIcon from "@assets/icons/cloud.svg"

interface IForm {
  files: FileList;
}

export const Form: FC = () => {
  const {
    handleSubmit,
    register,
    formState: { errors },
  } = useForm<IForm>();

  const onSubmit = (data) => {
    console.log(data);
  };

  const handleFileChange = (event) => {
    const files = event.target.files;
    if (files.length > 5) {
      alert("Вы можете загрузить не более 5 файлов");
      event.target.value = "";
    }
  };

  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleButtonClick = () => {
    fileInputRef.current?.click();
  };

  return (
    <form className={s.form} onSubmit={handleSubmit(onSubmit)}>
      <img src={cloudIcon} alt="Cloud" />
      <p className={s.text}>Перетащите .csv файлы сюда, чтобы получить золотую запись</p>
      <input
        {...register("files", {
          onChange: handleFileChange,
        })}
        ref={fileInputRef}
        className={s.input}
        type="file"
        accept=".csv"
        multiple
      />
      <ChooseButton className={s.chooseButton} onClick={handleButtonClick} />
      {errors.files && <p>{errors.files.message}</p>}
    </form>
  );
};
