# GitHub 安全版成本監控（MVP）

## 已完成
- 靜態頁：`docs/index.html`
- 成本資料：`docs/data/latest.json`
- 發佈腳本：`scripts/publish_dashboard.sh`

## 一次性設定

1. 建立 **private** GitHub repo（例如 `cost-dashboard`）
2. 在本機登入 GitHub CLI
   ```bash
   gh auth login
   ```
3. 設定 remote
   ```bash
   cd github-dashboard
   git remote add origin git@github.com:<YOUR_USER>/cost-dashboard.git
   ```
4. 啟用 GitHub Pages（from branch: `main`, folder: `/docs`）

## 例行發佈
```bash
bash github-dashboard/scripts/publish_dashboard.sh
```

## 安全強化（建議）
- GitHub repo 保持 private
- 如果要公開網址，前面再加 Cloudflare Access（GitHub OAuth）
- 只上傳彙總資料（不含 session id/token）
