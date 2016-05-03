set version=1_2_0
if not exist "output" (mkdir output)
ocra --output output/yecaigame_%version%.exe --windows --icon ant.ico ./run.rb