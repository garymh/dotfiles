// Karabiner's shell_command runs without a login shell, so it never sources
// zprofile — anything that needs credentials or PATH from the private zsh
// (dotbot symlinks ~/.zsh/private → ~/iCloud/Internal/private) has to source
// it explicitly. home/zprofile exports the same path as $PRIVATE_FILE.
export const privateZsh = "$HOME/.zsh/private/private.zsh";

export function withPrivateEnv(command: string) {
  return `source ${privateZsh} && ${command}`;
}
