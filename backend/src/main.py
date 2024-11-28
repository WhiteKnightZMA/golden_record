import uvicorn
import shutil
import os
import zipfile

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

current_dir = os.path.dirname(os.path.abspath(__file__))

@app.post("/upload/")
async def upload_file(file: UploadFile = File(...)):
    input_file = os.path.join(current_dir, "uploaded_file.csv")
    zip_file = os.path.join(current_dir, "processed_file.zip")
    output_file = os.path.join(current_dir, "processed_file.csv")
    with open(input_file, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    project_root = os.path.dirname(os.path.dirname(current_dir))
    r_script_path = os.path.join(project_root, "analysis_processing_r", "analysis,processing.R")

    ro.r.source(r_script_path)

    func_r = ro.r['function_r']

    try:
        processed_file_path = func_r(input_file, project_root)
        
        shutil.move(processed_file_path, output_file)

        with zipfile.ZipFile(zip_file, 'w') as zipf:
            zipf.write(output_file, arcname="processed_file.csv")
    except Exception as e:
        return {"error": str(e)}
    
    return FileResponse(zip_file, media_type="application/zip", filename="processed_file.zip")

if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8080, reload=True)