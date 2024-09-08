### Workflow Permissions

Choose the default permissions granted to the `GITHUB_TOKEN` when running workflows in this repository. You can specify more granular permissions in the workflow using YAML. 

#### Permissions Options:
- **Read and write permissions**
  
为了确保 **GitHub Actions** 能够手动触发 release，需要在仓库的 <code style="background-color: #FFFF00">Settings</code> 下找到 <code style="background-color: #FFFF00">Actions</code>，然后在 <code style="background-color: #FFFF00">General</code> 选项卡中，将 **Workflow permissions** 调整为 <code style="background-color: #FFFF00">Read and write permissions</code>。这样可以确保你的 Actions 有足够的权限来创建和管理发布。
