@echo off
echo Before use this batch script, change the image_dir to the actual image directory you want to add water mark

set image_dir=%cd%"\images"
for /r %image_dir% %%f in (*.dcm) do %cd%"\WaterMark.exe" "%%f"
for /r %image_dir% %%f in (*.raw) do %cd%"\WaterMark.exe" "%%f"

echo Script finished, press any key to close this program...


