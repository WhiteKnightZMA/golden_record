import { useMutation } from "@tanstack/react-query";
import { uploadFileApi } from "./api";
import { showFormStore } from "@store/showForm";

export const useUploadFile = () => {
  const { mutate, isError, isSuccess, isPending } = useMutation({
    mutationFn: async ({ file }: { file: File }) => {
      const response = await uploadFileApi.uploadFile(file);
      console.log(response)
      return response;
    },
    onSettled: () => showFormStore.hideForm(),
  });

  const uploadFile = (file: File) => mutate({ file });

  return { uploadFile, isSuccess, isError, isPending };
};
