class ProductRoot::Jd < ProductRoot
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  def get_lists
    Nokogiri::HTML(http_get(url), nil, Site::Jd::ENCODING).css('.crumbs-nav-item').last.css('a').map{ |a| a.attr("href") }.each do |url|
      ProductList::Jd.create(url: "http:#{url}")
    end
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end