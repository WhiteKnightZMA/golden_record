import { PageLayout } from "@app/layouts/PageLayout";
import { FC } from "react";
import s from "./Home.module.css";
import { Form } from "@/modules/Form";
import { useUploadFile } from "@/modules/Form/api/useUploadFile";
import { DownloadFiles } from "@/modules/DownloadFiles";
import { showFormStore } from "@store/showForm";
import { observer } from "mobx-react-lite";
import { Loader } from "@/shared/components/Loader";

export const Home: FC = observer(() => {
  const { uploadFile, isError, isPending, isSuccess } = useUploadFile();

  const { isShowForm } = showFormStore;

  const handleUploadFile = (file: File) => uploadFile(file);
  return (
    <PageLayout>
      <div className={s.homePage}>
        <h1 className={s.title}>
          Добро пожаловать в <span className={s.golden}>Golden</span>
          <span className={s.record}>Record</span>
        </h1>
        <h2 className={s.secondaryTitle}>
          Найдите золотую запись в большом наборе данных
        </h2>
        <div className={s.formWrapper}>
          {isShowForm && !isPending && <Form onFileUpload={handleUploadFile} />}
          {isPending && <Loader />}
          {isError && !isShowForm && <DownloadFiles />}
        </div>
      </div>
    </PageLayout>
  );
});
