import uvicorn
import shutil
import os

os.environ["R_HOME"] = "C:\Program Files\R\R-4.4.2"

import rpy2.robjects as ro

from fastapi import FastAPI, UploadFile, File
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = ["http://localhost:5173"]

app.add_middleware(
    CORSMiddleware,
    allow_origins = origins,
    allow_credentials = True,
    allow_methods= ["*"],
    allow_headers = ["*"]
)

@app.post("/upload/")
async def upload_file(file: UploadFile = File(...)):
    input_file = "D:/Рабочий стол/coding/golden_record/backend/src/uploaded_file.csv"
    output_file = "processed_file.csv"
    with open(input_file, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    r_script_path = "D:/Рабочий стол/coding/golden_record/analysis_processing_r/analysis,processing.R"

    ro.r.source(r_script_path)

    func_r = ro.r['function_r']

    try:
        processed_file_path = func_r(input_file, "D:/Рабочий стол/coding/golden_record/analysis_processing_r")
        
        shutil.move(processed_file_path, output_file)
    except Exception as e:
        return {"error": str(e)}
    
    return FileResponse(output_file, media_type="text/csv", filename="processed_file.csv")

if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8080, reload=True)