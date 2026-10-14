// Karabiner's shell_command gets no login shell, so source the private zsh env explicitly
// (the same file as $PRIVATE_FILE).
export const privateZsh = "$HOME/.zsh/private/private.zsh";

export function withPrivateEnv(command: string) {
  return `source ${privateZsh} && ${command}`;
}
