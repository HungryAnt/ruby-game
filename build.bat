set version=0_4_beta_inner
if not exist "output" (mkdir output)
ocra --output output/yecaigame_%version%.exe --windows --icon ant.ico src/main.rb media