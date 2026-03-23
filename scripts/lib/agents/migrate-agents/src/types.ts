type VeryFocusedAndDeterministicTemperature = 0 | 0.1 | 0.2;
type BalancedWithSomeCreativityTemperature = 0.3 | 0.4 | 0.5;
type MoreCreativeAndVariedTemperature = 0.6 | 0.7 | 0.8 | 0.9 | 1;
type Temperature =
  | VeryFocusedAndDeterministicTemperature
  | BalancedWithSomeCreativityTemperature
  | MoreCreativeAndVariedTemperature;
type AgentActions = 'ask' | 'allow' | 'deny';
type AgentMode = 'primary' | 'subagent' | 'all';

export interface AgentPermission {
  edit?: AgentActions;
  bash?: AgentActions;
  webfetch?: AgentActions;
}

export interface AgentTools {
  read?: boolean;
  write?: boolean;
  edit?: boolean;
  bash?: boolean;
}

export type AgentConfig = {
  description?: string;
  temperature?: Temperature;
  steps?: number;
  disable?: boolean;
  prompt?: string;
  model?: string;
  tools?: AgentTools | Record<string, boolean>; // Deprecated, use permission.
  permission?: AgentActions | AgentPermission | Record<string, any>;
  mode?: AgentMode;
  hidden?: boolean;
  color?: string;
  top_p?: Temperature;
} & Record<string, any>;

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
