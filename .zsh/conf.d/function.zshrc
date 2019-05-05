# ffmpeg -i in.mov -vf scale=800:-1 -pix_fmt rgb24 -r 25 -f gif - | gifsicle --optimize=3 --delay=3 > out.gif
# ffmpeg -i Untitled.mov -vf scale=800:-1 -pix_fmt rgb24 -r 25 -f gif - | gifsicle --optimize=3 --delay=3 > Untitled.gif
