export interface SquarePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
