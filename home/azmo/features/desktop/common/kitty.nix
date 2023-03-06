{pkgs, ...}:
let
 nvim-minimal = pkgs.writeTextFile {
  name = "nvim-minimal.vim";
  executable = false;
  text = ''
    set relativenumber
    set number
    set mouse=a
    set clipboard+=unnamedplus
    set virtualedit=all
    set scrollback=100000
    set termguicolors
    set laststatus=0
    set background=dark
    set ignorecase
    set scrolloff=8

    map <silent> q :qa!<CR>

    " Short highlight on yanked text
    augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
    augroup END

    augroup start_at_bottom
        autocmd!
        autocmd VimEnter * normal G
    augroup END

    augroup prevent_insert
        autocmd!
        autocmd TermEnter * stopinsert
    augroup END
   '';
  };
in
{
    programs.kitty = {
     enable = true;
     font = {
      name = "Iosevka Medium";
      size = 11.0;
     };
     theme = "Catppuccin-Macchiato";
     settings = {
      modify_font = "underline_position 1";
      wayland_titlebar_color = "background";
      enable_audio_bell = "no";
      visual_bell_duration = "1.0";
      window_alert_on_bell = "1.0";
      cursor_blink_interval = "1";
      cursor_stop_blinking_after = "15";

      paste_actions = "quote-urls-at-prompt,confirm";
      tab_bar_style = "powerline";
      active_tab_font_style = "bold";

      window_padding_width = "1 1 1 1";
      inactive_text_alpha = "0.9";

      scrollback_lines = "10000";
      scrollback_pager = "${pkgs.neovim-nightly}/bin/nvim -u ${nvim-minimal} -c 'set signcolumn=no showtabline=0' -c 'silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer - '";
      scrollback_pager_history_size = "20";
     };
    };
}
