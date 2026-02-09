/**
 * Skills discovery and resolution for compound-engineering.
 * Scans for SKILL.md files and extracts frontmatter metadata.
 */

const fs = require("fs");
const path = require("path");

const MAX_DEPTH = 3;

function extractFrontmatter(content) {
  const match = content.match(/^---\n([\s\S]*?)\n---/);
  if (!match) return {};
  const frontmatter = {};
  match[1].split("\n").forEach((line) => {
    const [key, ...rest] = line.split(":");
    if (key && rest.length) {
      frontmatter[key.trim()] = rest.join(":").trim().replace(/^["']|["']$/g, "");
    }
  });
  return frontmatter;
}

function discoverSkills(dir, depth = 0) {
  if (depth > MAX_DEPTH) return [];
  const skills = [];
  try {
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    for (const entry of entries) {
      const fullPath = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        const skillFile = path.join(fullPath, "SKILL.md");
        if (fs.existsSync(skillFile)) {
          const content = fs.readFileSync(skillFile, "utf-8");
          const meta = extractFrontmatter(content);
          skills.push({
            path: skillFile,
            name: meta.name || entry.name,
            description: meta.description || "",
            sourceType: "compound-engineering",
          });
        }
        skills.push(...discoverSkills(fullPath, depth + 1));
      }
    }
  } catch (e) {
    // Directory not readable, skip
  }
  return skills;
}

module.exports = { discoverSkills, extractFrontmatter };
