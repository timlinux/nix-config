{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    extraConfig = ''
      # Start maximized
      map winmax toggle maximize_window
      # Kartoza Kitty Theme
      background_opacity 0.95
      font_size 18
      foreground #C3C7D1
      background #0D181E
      selection_foreground #C3C7D1
      selection_background #4f5b66
      url_color #6699cc
      active_border_color #528BFF
      inactive_border_color #404753
      cursor #DF9E2F
      cursor_text_color #C3C7D1
      scrollback_lines 10000
      hide_window_decorations no
      tab_activity_symbol 🔔
      tab_bar_style powerline
      tab_powerline_style angled
      tab_title_format '{title}'
      tab_title_style 'bold'
      tab_max_width '20%'
      tab_max_width_auto_shrink no
      tab_bar_background #DF9E2F
      active_tab_background #569FC6
      tab_title_template "💻️ {fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"
      active_tab_title_template "⚙️ {fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}"
      tab_font 'Hack, Monaco, "DejaVu Sans Mono", monospace'
    '';
  };
}
