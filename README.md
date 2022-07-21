# Motion Energy Images
<i>Motion Energy Images</i> or <i>Motion History Images</i> could be defined as the pixel regions of the frame where there is motion.

## Inter-frame Differencing Method
The frame difference method is the common method of motion detection. This method adopts pixel-based difference to find the moving object, i.e., <i> D(x, y, t) = I(x, y, t) - I(x, y, t-1)</i>, where <i>I(x, y, t)</i> is the frame intensity for frame <i>t</i> at pixel <i>(x,y)</i>.

Following animations show the results for our test cases.
<p align="center">
  <img src="https://github.com/rimshasaeed/motion-energy-images/blob/main/results/inter_frame_differencing/bend.gif", alt="motion: bend" width="50%">
  <br>
  <i>Bend</i>
</p>
<p align="center">
  <img src="https://github.com/rimshasaeed/motion-energy-images/blob/main/results/inter_frame_differencing/skip.gif", alt="motion: skip" width="50%">
  <br>
  <i>Skip</i>
</p>
<p align="center">
  <img src="https://github.com/rimshasaeed/motion-energy-images/blob/main/results/inter_frame_differencing/jump.gif", alt="motion: jump" width="50%">
  <br>
  <i>Jump</i>
</p>
In order to clean the holes, the image can be passed through the Gaussian low pass filter or certain morphological operations.

## Lucas-Kanade Method
Optical flow estimation is the method of calculating the motion vector between two frames which are taken at a specific time. The algorithm works by trying to guess in which direction an object has moved so that local changes in intensity can be explained.

Following animations show the results for our test cases.
<p align="center">
  <img src="https://github.com/rimshasaeed/motion-energy-images/blob/main/results/lukas_kanade_method/bend.gif", alt="motion: bend" width="50%">
  <br>
  <i>Bend</i>
</p>
<p align="center">
  <img src="https://github.com/rimshasaeed/motion-energy-images/blob/main/results/lukas_kanade_method/skip.gif", alt="motion: skip" width="50%">
  <br>
  <i>Skip</i>
</p>
<p align="center">
  <img src="https://github.com/rimshasaeed/motion-energy-images/blob/main/results/lukas_kanade_method/jump.gif", alt="motion: jump" width="50%">
  <br>
  <i>Jump</i>
</p>
