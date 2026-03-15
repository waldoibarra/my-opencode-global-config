import { existsSync } from 'node:fs';
import { join, resolve } from 'node:path';

const openCodeJsonFileName = 'opencode.json';
const agentsDirectoryName = 'agents';

function showErrorAndExit(message: string) {
  console.error(message);
  process.exit(1);
}

function validateExistance(fileOrDirectoryPath: string, errorMessage: string) {
  if (!existsSync(fileOrDirectoryPath)) {
    showErrorAndExit(errorMessage);
  }
}

export function getRepoRoot(): string {
  const arg = process.argv?.[2];

  if (!arg) {
    showErrorAndExit('Must call script with the repository root.');
  }

  const repoRoot = resolve(arg);

  validateExistance(repoRoot, 'Script argument must be a valid directory.');

  return repoRoot;
}

export function getMigrationPaths(repoRoot: string): {
  openCodeJsonPath: string;
  agentsPath: string;
} {
  const openCodeJsonPath = join(repoRoot, openCodeJsonFileName);
  const agentsPath = join(repoRoot, agentsDirectoryName);

  validateExistance(
    openCodeJsonPath,
    `${openCodeJsonFileName} file does not exist on ${repoRoot}.`,
  );

  validateExistance(
    agentsPath,
    `${agentsDirectoryName} directory does not exist on ${repoRoot}.`,
  );

  return {
    openCodeJsonPath,
    agentsPath,
  };
}
