### Workflow Permissions

Choose the default permissions granted to the `GITHUB_TOKEN` when running workflows in this repository. You can specify more granular permissions in the workflow using YAML. 

#### Permissions Options:
- **Read and write permissions**
  
为了确保 **GitHub Actions** 能够手动触发 release，需要在仓库的 `Settings` 下找到 `Actions`，然后在 `General` 选项卡中，将 **Workflow permissions** 调整为 **Read and write permissions**。这样可以确保 Actions 有足够的权限来创建和管理发布。

