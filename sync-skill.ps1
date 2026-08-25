# 同步仓库 SKILL.md 到 TraeCN 全局 skill 安装位置
$skillPath = "$HOME\.trae-cn\skills\math-modeling-helper"
$repoSkill = "SKILL.md"

if (-not (Test-Path $repoSkill)) {
    Write-Error "找不到 SKILL.md"
    exit 1
}

New-Item -ItemType Directory -Force -Path $skillPath | Out-Null
Copy-Item -Path $repoSkill -Destination (Join-Path $skillPath "SKILL.md") -Force
Write-Host "已更新全局 skill: $skillPath\SKILL.md"
