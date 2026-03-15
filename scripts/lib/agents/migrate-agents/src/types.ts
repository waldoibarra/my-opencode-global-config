export interface AgentPermission {
  task?: Record<string, string>;
}

export interface AgentTools {
  read?: boolean;
  write?: boolean;
  edit?: boolean;
  bash?: boolean;
}

export interface AgentConfig {
  description?: string;
  mode?: string;
  model?: string;
  temperature?: number;
  hidden?: boolean;
  permission?: AgentPermission;
  tools?: AgentTools;
  prompt?: string;
}

export interface OpenCodeConfig {
  agent?: Record<string, AgentConfig>;
}

export interface ExistingFrontmatter {
  description?: string;
  mode?: string;
  model?: string;
  temperature?: number;
  hidden?: boolean;
  permission?: AgentPermission;
  tools?: AgentTools;
}
