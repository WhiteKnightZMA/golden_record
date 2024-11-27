import axios from "axios";
import { baseUrl } from "./config";

const fileControllerApi = axios.create({
  baseURL: baseUrl,
});

export const uploadFile = (file: File) => {
  const formData = new FormData();
  formData.append("file", file);
  return fileControllerApi.post("/upload/", formData);
};
