import { migrateAllAgents } from './migrator.js';
import { getMigrationPaths, getRepoRoot } from './fs-helpers.js';

const repoRoot = getRepoRoot();
const { openCodeJsonPath, agentsPath } = getMigrationPaths(repoRoot);

console.log('Migrating agents from opencode.json to Markdown files...\n');

migrateAllAgents({ openCodeJsonPath, agentsPath });

console.log('\n✨ Migration complete!');
