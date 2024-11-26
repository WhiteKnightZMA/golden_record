import uvicorn
import pandas as pd
from fastapi import FastAPI, UploadFile, File
from fastapi.responses import FileResponse

app = FastAPI()

@app.post("/upload/")
async def upload_file(file: UploadFile = File(...)):
    data = pd.read_csv(file.file)
    data = data.drop_duplicates()
    n = len(data)
    output_file = "updated_file.csv"
    data.to_csv(output_file, index=False)
    
    return {"message": f"Найдено {n} золотых записей.", "file": output_file}

@app.get("/download/")
async def download_file():
    return FileResponse("updated_file.csv", media_type="text/csv", filename="updated_file.csv")

if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8080, reload=True)