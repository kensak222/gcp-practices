# gcp-practices
GCPの練習用のリポジトリ

## mattermost-kenken-k8s

<details>

<summary>クリックして詳細を確認してください。</summary>

# Mattermost サービスのインフラ構築と管理 (日本語版)

このプロジェクトは、GCP 上で Mattermost サービスを Kubernetes を使用してホストし、Cloudflare を利用した DDoS 保護および SSL/TLS 暗号化を提供するためのインフラストラクチャコードを含んでいます。

## アーキテクチャ図
以下は、このプロジェクトの全体的なアーキテクチャを示した図です。

![アーキテクチャ図](https://github.com/kensak222/gcp-practices/blob/feat/mattermost-kenken-k8s/mattermost-k8s/others/architecture.png)

## 特徴

- **Google Kubernetes Engine (GKE):** Mattermost アプリケーションをデプロイ。
- **Cloud SQL:** Mattermost 用の PostgreSQL データベースをホスト。
- **Cloud Storage:** ファイルストレージ用。
- **Cloudflare:** DNS、CDN、DDoS 保護、SSL/TLS 暗号化を管理。
- **Terraform:** インフラ構築のコード管理。

## プロジェクト構造

```
mattermost-k8s/
├── main.tf                  # Terraform メインファイル
├── providers.tf            # プロバイダー設定 (GCP、Kubernetes、Cloudflare)
├── modules/
│   ├── gke/                # GKE クラスタの設定
│   ├── sql/                # Cloud SQL の設定
│   ├── storage/            # Cloud Storage の設定
│   ├── firewall/           # ファイアウォールルールの設定
│   ├── vpc/                # VPC、サブネット、NAT、VPC Peering の設定
│   └── cloudflare/         # Cloudflare の設定
└── others/
    └── architecture.png    # アーキテクチャ図
```

## 必要条件

- **Terraform:** インフラコードの適用。
- **gcloud CLI:** GCP プロジェクトの操作。
- **kubectl:** Kubernetes リソースの管理。
- **Cloudflare アカウント:** DNS とセキュリティ管理。

## セットアップ手順

### 1. GCP プロジェクトの準備
1. GCP プロジェクトを作成。
2. [API を有効化](https://console.cloud.google.com/apis) (Compute Engine, Kubernetes Engine, Cloud SQL, Cloud Storage)。
3. サービスアカウントを作成し、必要なロール (例: Owner, Editor) を付与。

### 2. Terraform のセットアップ
1. `terraform init` を実行して Terraform を初期化。
2. `terraform plan` で計画を確認。
3. `terraform apply` を実行してインフラをデプロイ。

### 3. Cloudflare の設定
1. [Cloudflare にログイン](https://dash.cloudflare.com/) し、新しいドメインを追加。
2. Mattermost の IP アドレスを指す A レコードを作成。
3. 必要に応じてサブドメイン (CNAME レコード) を設定。
4. Cloudflare の SSL/TLS 設定を「フル (厳密)」に設定。

### 4. Kubernetes リソースの適用
1.	スクリプトに実行権限を付与します。
chmod +x mattermost-k8s/others/*.sh
2.	各スクリプトを順番に実行します。
  - Ingress Controllerのデプロイ
    - mattermost-k8s/others/setup_ingress.sh
  - Cert-Managerのデプロイ
    - mattermost-k8s/others/setup_cert_manager.sh
  - Mattermost Namespaceと関連リソースの作成
    - mattermost-k8s/others/deploy_resources.sh
  - 状態確認
    - mattermost-k8s/others/check_status.sh

### 5. 動作確認
- `curl` やブラウザを使用して Mattermost にアクセス。
- Cloudflare のダッシュボードでトラフィックやセキュリティのステータスを確認。

## 注意事項
- **コスト管理:** 各リソースの使用量をモニタリングし、予算を超えないように注意してください。
- **セキュリティ:** Cloudflare のセキュリティ機能を有効にし、不要なポートやアクセスを制限してください。
- **Terraform ステート管理:** Terraform の状態ファイルを安全な場所に保管してください。

---

このプロジェクトに関する質問や提案があれば、遠慮なくお知らせください！

</details>
