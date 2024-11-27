import uvicorn
from fastapi import FastAPI, UploadFile, File
from fastapi.responses import FileResponse
from services.processor import process_file

app = FastAPI()

@app.post("/upload/")
async def upload_file(file: UploadFile = File(...)):
    output_file = "processed_file.csv"

    _ = process_file(file.file, output_file)
    
    return FileResponse(output_file, media_type="text/csv", filename=output_file)

if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8080, reload=True)