import * as fs from 'node:fs';
import * as path from 'node:path';

import * as yaml from 'js-yaml';

import type {
  AgentConfig,
  ExistingFrontmatter,
  OpenCodeConfig,
} from './types.js';

const FRONTMATTER_DELIMITER = '---';

function quoteYamlKeys(yamlStr: string): string {
  const lines = yamlStr.split('\n');
  return lines
    .map((line) => {
      const match = line.match(/^(\s*)([^:]+):(.*)$/);
      if (!match) return line;

      const [, indent, key, value] = match;
      const trimmedKey = key.trim();

      if (trimmedKey.startsWith('"') && trimmedKey.endsWith('"')) {
        return line;
      }

      if (
        trimmedKey.includes('*') ||
        trimmedKey.includes('-') ||
        trimmedKey.includes(' ') ||
        /^\d/.test(trimmedKey)
      ) {
        return `${indent}"${trimmedKey}":${value}`;
      }
      return line;
    })
    .join('\n');
}

function readOpencodeJson(jsonPath: string): OpenCodeConfig {
  const content = fs.readFileSync(jsonPath, 'utf-8');
  const parsed: OpenCodeConfig = JSON.parse(content);
  return parsed || {};
}

function readFrontmatterFromExistingMarkdown(
  markdownPath: string,
): ExistingFrontmatter | null {
  if (!fs.existsSync(markdownPath)) {
    return null;
  }

  const content = fs.readFileSync(markdownPath, 'utf-8');
  const lines = content.split('\n');

  if (lines[0] !== FRONTMATTER_DELIMITER) {
    return null;
  }

  let endIndex = -1;
  for (let i = 1; i < lines.length; i++) {
    if (lines[i].trim() === FRONTMATTER_DELIMITER) {
      endIndex = i;
      break;
    }
  }

  if (endIndex === -1) {
    return null;
  }

  const yamlContent = lines.slice(1, endIndex).join('\n');
  const frontmatter = yaml.load(yamlContent) as ExistingFrontmatter;
  return frontmatter;
}

function buildFrontmatter(
  agent: AgentConfig,
  existingAgent: ExistingFrontmatter | null,
): Record<string, unknown> {
  const { prompt, ...agentConfig } = agent;
  const frontmatter: Record<string, unknown> = {
    ...agentConfig,
    model: existingAgent?.model || agent.model,
  };

  return frontmatter;
}

function writeMarkdownFile(
  markdownPath: string,
  frontmatter: Record<string, unknown>,
  prompt: string,
): void {
  const yamlContent = yaml.dump(frontmatter, {
    lineWidth: -1,
    noRefs: true,
    quotingType: '"',
  });

  const quotedYamlContent = quoteYamlKeys(yamlContent);

  const content = [
    FRONTMATTER_DELIMITER,
    quotedYamlContent.trim(),
    FRONTMATTER_DELIMITER,
    '',
    prompt || '',
    '',
  ].join('\n');

  fs.writeFileSync(markdownPath, content);
}

function removeAgentFieldFromJson(openCodeJsonPath: string): void {
  const content = fs.readFileSync(openCodeJsonPath, 'utf-8');
  const parsed = JSON.parse(content);

  if (parsed.agent) {
    delete parsed.agent;
    fs.writeFileSync(openCodeJsonPath, JSON.stringify(parsed, null, 2) + '\n');
    console.log('✅ Removed "agent" field from opencode.json');
  }
}

export function migrateAllAgents({
  openCodeJsonPath,
  agentsPath,
}: {
  openCodeJsonPath: string;
  agentsPath: string;
}): void {
  const openCodeConfig = readOpencodeJson(openCodeJsonPath);
  const agents = Object.entries(openCodeConfig.agent || {});

  if (!agents.length) {
    console.log('There are no agents in the JSON.');
    return;
  }

  for (const [agentName, agent] of agents) {
    const markdownPath = path.join(agentsPath, `${agentName}.md`);
    const existingAgent = readFrontmatterFromExistingMarkdown(markdownPath);

    const frontmatter = buildFrontmatter(agent, existingAgent);
    const prompt = agent.prompt || '';

    writeMarkdownFile(markdownPath, frontmatter, prompt);
    console.log(`✅ Migrated: ${agentName}.md`);
  }

  removeAgentFieldFromJson(openCodeJsonPath);
}
