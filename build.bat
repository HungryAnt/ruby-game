set version=0_9_0_beta
if not exist "output" (mkdir output)
ocra --output output/yecaigame_%version%.exe --windows --icon ant.ico ./run.rb