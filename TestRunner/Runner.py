import os
from datetime import datetime
from robot import run
from pathlib import Path

targetDirectory = os.path.dirname(Path.cwd())
pathToTests = targetDirectory + "/Tests"
pathToResultFiles = targetDirectory + "/TestReport/"
current_datetime = datetime.now()

for filename in os.listdir(pathToResultFiles):
    file_path = os.path.join(pathToResultFiles, filename)
    if os.path.isfile(file_path):
        os.remove(file_path)

run(pathToTests, outputdir=pathToResultFiles, timestampoutputs=current_datetime)
