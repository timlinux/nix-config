{
  programs.mc = {
    enable = true;
    extraConfig = ''
      [Colors]
      base_color=white,black:normal
      selected=black,cyan:standout
      marked=white,red:marked
      markselect=black,yellow:marked,standout
      error=white,red:standout
      info=green,black:normal
      left_title=yellow,blue:normal
      left_normal=white,black:normal
      left_marked=black,cyan:marked
      left_markselect=black,yellow:marked,standout
      right_title=yellow,blue:normal
      right_normal=white,black:normal
      right_marked=black,cyan:marked
      right_markselect=black,yellow:marked,standout
      title=white,blue:normal
      [Panels]
      messagebox=white,red:standout
      dialog=white,red:standout
      [Layout]
      horizontal=,blue
      vertical=,blue
      [Miscellany]
      editor=white,black:normal
      status=white,black:normal
      scrollbar=black,cyan
    '';
  };
}

