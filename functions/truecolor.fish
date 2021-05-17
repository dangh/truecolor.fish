# from https://unix.stackexchange.com/a/404415
function truecolor --argument-names width --description "test true color in terminal"
  if not test $width -gt 0
    if command --query tput
      set width (command tput cols)
    else
      set width 80
    end
  end
  awk -v term_cols=$width 'BEGIN{
    s = "/\\\";
    for(colnum = 0; colnum < term_cols; colnum++) {
      r = 255-(colnum*255/term_cols);
      g = (colnum*510/term_cols);
      b = (colnum*255/term_cols);
      if(g > 255) g = 510-g;
      printf "\033[48;2;%d;%d;%dm", r,g,b;
      printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
      printf "%s\033[0m", substr(s,colnum%2+1,1);
    }
    printf "\n";
  }'
end
