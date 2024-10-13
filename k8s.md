# kubernetes

k8s 用の設定メモ

- kubectl のプラグインは krew で一元管理することにした
- k8s 向けのツールはこれまでどおり [officel/config_aqua: .config/aqua](https://github.com/officel/config_aqua) で管理する

# kubernetes 関連

- 入っているものは [aqua.yaml](https://github.com/officel/config_aqua/blob/main/aqua.yaml) を参照
- `alias k` を `kubecolor` にした
- `alias stern` を `kubectl stern` にした（krew でインストールしたので）

# kubectl plugins use krew

- [Krew – kubectl plugin manager](https://krew.sigs.k8s.io/)

```bash
# インストール済のプラグインのリストをバックアップ
# https://krew.sigs.k8s.io/docs/user-guide/list/
kubectl krew list | tee krew.list

# krew.list を使って再インストール
kubectl krew install < krew.list

# 時々アップデート
# https://krew.sigs.k8s.io/docs/user-guide/upgrading-plugins/
kubectl krew upgrade
```

# note

## krew install

```bash
# https://krew.sigs.k8s.io/docs/user-guide/setup/install/
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
```
