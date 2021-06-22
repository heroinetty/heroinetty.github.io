1) 为什么要用CI/CD
2) 有了SVN,为什么还要用git -> gitlab -> gitlab-runner
3) git, gitlab, gitlab-runner 三者之间的关系
4) 如何使用gitlab管理项目
5) 如何给配置CI/CD

Toptic:
X公司的敏捷scrum模式：
    *  prestudy: 产品部、研发部需求调研
sprint (迭代周期8周左右比较合理)
    *  grooming meeting：【需求讨论（头脑风暴）】 -> 研发部 和 产品部
       Backlog -> User Story -> Task（指派）

    *  planning meeting: 研发内部 -> 敏捷牌进行合计（"专家判断"会议模式）
        每个（User Story）Task需要的周期，按照指派人员根据工时（8小时/人/天）确认工作完成时间，解决项目提前或延期问题（可接受：75%~125%）

    *  daily meeting: 项目成员内部每日站会（禅道燃尽图，看板）-> 项目负责人
        昨天完成任务，今天计划，有什么问题（延期，风险）
            针对每个Backlog可能的状态： To Do, Doing, Done(Closed),Blocked

    *  review meeting: 研发 和 测试 -> 过禅道的bug
        bug 状态的处理（发版前）: 该解决的解决，需求相关（可能需要产品部参与），该延期处理的延期处理

    *  retrospective meeting: 项目组 -> wiki记录（gitlab 每个项目本身）
        经验与反思： 
            1) 哪里做的比较好的（Better)： 经验
            2) 哪里可以做的更好（Should better）: issues -> Tips or Tricks

1) 为什么要用CI/CD:
    意义：   
        集成，交互（研发，测试，发版）: 与测试，与其它部门的交互，交接   
        测试与研发可以是同步的   
                a. 研发: 接口 -> 模块等相互关联的依赖  
                b. 测试: 测试用例->测试模块通信机制 -> 功能, 控制版本  
2) 为什么要用gitlab
    1. code review? comments 代码风格的规范
    2. 反馈研发部领导（副经理和副总），同步项目进度（计划，进行中，完成），评估有什么风险 -> Line Meeting(2周一次，推荐是2-3周一次)
        研发部门领导：了解项目进度
        研发部门领导：同步领导层的抉择
        （成员之间有什么别的topic）
    3. 绩效可追溯（对项目贡献，提交记录，图表可追溯 -> 代码质量）
        个人：
            a. 代码质量的评估
            b. 提交次数与贡献的权重问题？ 提交的多，共享大？ 需要处理comments多？ 贡献又该如何权重
            c. 提comments多的人，奖励机制
        公司：
            项目预览，合并分支发版事件记录
3) git, gitlab, gitlab-runner 三者之间的关系
    git： 版本控制， 类似与SVN
    gitlab: 网页，项目管理，直观
    gitlab-ruuner: 配置CI/CD, 触发机制，运行CI/CD
4) 如何使用gitlab项目管理
    1. 权限管理：
        a. 用户角色：
            root： 系统管理员权限管理，特有：监控系统状态
            
            Guest: 可以创建issue、发表评论，不能读写版本库
            Reporter: 可以克隆代码，不能提交，QA、PM可以赋予这个权限
            Developer: 可以克隆代码，开发、提交、push，RD可以赋予这个权限
            Master: 可以创建项目、添加Tag、保护分支、添加项目成员、编辑项目、核心RD负责人可以赋予这个权限
            Owner: 可以设置项目的访问权限-Visibility Level、删除项目、迁移项目、管理组成员、开发组leader可以赋予这个权限
        b. 对于项目：
            Private: 只有组成员才能看到
            Internal: 只要登陆的用户就能看到
            Public: 所有人都能看见
    Tricks: 建议采用分组管理，分项目授权
    2. 签名配置：
        git 管理用户签名: 建议全局配置
            git config --global user.name "xxx"
            git config --global user.email "xxx" 
    3. 项目管理：
        a. 创建项目
            (1) 创建git版本库(git init) -> 工作区
            (2) 添加项目暂存区(git add)
            (3) 查看改动情况(git status/git diff)
            (4) 提交到本地仓库区(git commit) 
            [5] 添加到远程远程仓库区(git remote add 全路径简称 全路径)  -> Tricks: 提交代码之前一定要更新代码（git pull）, 防止引起冲突（解决冲突： git rebase）
            (6) 推送到远程仓库区（git push）
        b. 从远程库克隆到本地代码(git clone) 免密登录： ssh
        c. 拉取最新代码(git pull = git fetch + git merge)
        d. 文件回退当前的改动到当前版本(git checkout)
        e. 版本回退
            (1) 回退到某一指定版本（git reset 覆盖该要回退版本的后面的版本）
            (2) 回退某一指定版本（git revert 只回退该版本，不会覆盖后面的改本，原理：最新版本后面建一个版本，根据版本diff版本信息回退需要回退版本的改动）
        f. 创建分支 (git chekout)
        g. 分支查看 (git branch) 
        h. 合并项目 (git merge)
	      Tips: 切换成主分支，再进行合并: git merge dev
        i. 删除项目 (页面操作)
5）如何给配置CI/CD
    注册gitlba-runner: gitlab-runner register
    配置项目的触发机制：  .gitlab-ci.yml