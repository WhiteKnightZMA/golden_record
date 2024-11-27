import { PageLayout } from "@app/layouts/PageLayout";
import { FC } from "react";
import s from "./Home.module.css";
import { Form } from "@/modules/Form";

export const Home: FC = () => {
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
          <Form />
        </div>
      </div>
    </PageLayout>
  );
};
