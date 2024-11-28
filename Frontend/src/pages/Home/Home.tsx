import { PageLayout } from "@app/layouts/PageLayout";
import { FC, useState } from "react";
import s from "./Home.module.css";
import { Form } from "@/modules/Form";
import { useUploadFile } from "@/modules/Form/api/useUploadFile";
import { showFormStore } from "@store/showForm";
import { observer } from "mobx-react-lite";
import { Loader } from "@/shared/components/Loader";
import { Error } from "@/shared/components/Error";
import { DownloadFile } from "@/modules/DownloadFile";

export const Home: FC = observer(() => {
  const { uploadFile, isError, isPending, isSuccess } = useUploadFile();
  const [processedFile, setProccesFile] = useState({
    name: "",
    link: "",
  });

  const { isShowForm } = showFormStore;

  const handleUploadFile = (file: File) => {
    const processedFile = uploadFile(file);
    console.log(processedFile)
    // setProccesFile(processedFile);
  };

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
          {isSuccess && !isShowForm && <DownloadFile file={processedFile} />}
          {isError && !isShowForm && <Error />}
        </div>
      </div>
    </PageLayout>
  );
});
