{
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        indent_style = "space";
        indent_size = 4;
        tab_width = 4;
        end_of_line = "lf";
        insert_final_newline = true;
        trim_trailing_whitespace = true;
        charset = "utf-8";
      };
      "*.nix" = {
        indent_style = "space";
        indent_size = 2;
      };
      "*.md" = {
        trim_trailing_whitespace = false;
      };
      "*.sh" = {
        indent_style = "space";
        indent_size = 2;
        trim_trailing_whitespace = true;
      };
      "*.py" = {
        indent_style = "space";
        indent_size = 4;
        trim_trailing_whitespace = true;
      };
      "{Makefile,**.mk,go.mod,go.sum,*.go,.gitmodules}" = {
        indent_style = "tab";
        indent_size = 4;
      };
    };
  };
}
