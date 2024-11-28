import { FC } from "react";
import s from "./DownloadFile.module.css";
import fileIcon from "@assets/icons/file.svg";
import { DownloadButton } from "@/modules/DownloadButton";
import { IDownloadFile } from "../model/types";

export const DownloadFile: FC<IDownloadFile> = ({ file }) => {

  const handleDownloadFile = () => {
    
  }

  return (
    <div className={s.downloadFile}>
      <ul className={s.fileList}>
          <li className={s.fileItem}>
            <img className={s.fileIcon} src={fileIcon} alt="Icon" />
            <span className={s.fileName}>{file.name}</span>
          </li>
      </ul>
      <DownloadButton onClick={() => {}} />
    </div>
  );
};
