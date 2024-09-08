### Workflow Permissions

Choose the default permissions granted to the `GITHUB_TOKEN` when running workflows in this repository. You can specify more granular permissions in the workflow using YAML. 

#### Permissions Options:
- **Read and write permissions**
  
为了确保 **GitHub Actions** 能够手动触发 release，需要在仓库的 <span style="background-color: #FFFF00">`Settings`</span> 下找到 <span style="background-color: #FFFF00">`Actions`</span>，然后在 <span style="background-color: #FFFF00">`General`</span> 选项卡中，将 **Workflow permissions** 调整为 <span style="background-color: #FFFF00">`Read and write permissions`</span>。这样可以确保你的 Actions 有足够的权限来创建和管理发布。

