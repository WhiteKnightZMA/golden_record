import { useMutation } from "@tanstack/react-query";
import { uploadFileApi } from "./api";

export const useUploadFile = () => {
  const { mutate } = useMutation({
    mutationFn: ({ file }: { file: File }) => uploadFileApi.uploadFile(file),
  });

  const uploadFile = (file: File) => mutate({ file });

  return { uploadFile };
};
