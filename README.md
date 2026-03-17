# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### デバッグ方法
止めたい箇所に`binding.break`を記述。
ターミナルで
```rb
docker compose attach web
```
を実行後、ブラウザ画面で操作をする。

### Rails デバッグ手順（Docker）

止めたい箇所に binding.break を記述する

```rb
def property_params
  binding.break
  params.require(:property).permit(...)
end
```

Rails サーバーを起動

`docker compose up`

別ターミナルで web コンテナに attach

`docker compose attach web`

ブラウザで対象の操作を行う
→ binding.break の位置で処理が停止する

attach したターミナルでデバッグ操作を行う

例

p params
p params[:property]
n    # 次の行へ
c    # 続行
bt   # stack trace

デバッグ終了後

Ctrl + C

または

detach
