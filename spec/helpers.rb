module Helpers
  def build_jar(request, cookies)
    ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
  end
end
