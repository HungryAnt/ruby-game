set version=0_1_beta
if not exist "output" (mkdir output)
ocra --output output/yecaigame_%version%.exe --windows --icon ant.ico src/main.rb media src/resource