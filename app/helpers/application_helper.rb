module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice'
      'alert-success'
    when 'alert'
      'alert-warning'
    when 'error'
      'alert-danger'
    end
  end

  def project_name
    ' ASK '
  end
  
  def github_url(author, repo)
    "https://github.com/#{ author }/#{ repo }"
  end

  def current_year
    "© #{Time.current.year} "
  end

  def watch
    Time.now.strftime("%d.%m.%y ")
  end
end
