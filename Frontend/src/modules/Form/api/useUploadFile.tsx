import { useMutation } from "@tanstack/react-query";
import { uploadFileApi } from "./api";
import { showFormStore } from "@/store/showForm";

export const useUploadFile = () => {
  const { mutate, isError, isSuccess, isPending } = useMutation({
    mutationFn: ({ file }: { file: File }) => uploadFileApi.uploadFile(file),
    onError: () => showFormStore.hideForm(),
  });

  const uploadFile = (file: File) => mutate({ file });

  return { uploadFile, isSuccess, isError, isPending };
};
