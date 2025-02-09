class EmailNotificationMailer < ApplicationMailer
  # インスタンスメソッドだが呼び出す際はクラスメソッドで呼びだす
  # https://qiita.com/fursich/items/bb75a06714bcad6a0afb
  def send_email
    mail(to: "a@example.com", subject: "Test Email")
  end
end