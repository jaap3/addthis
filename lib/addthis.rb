module Jaap3
  module AddThisHelper
    module ClassMethods
      def addthis_bookmark_button(*args)
        url, options = extract_url_and_options(args)
        s = %Q{<a href="http://www.addthis.com/bookmark.php?v=20" onmouseover="return addthis_open(this, '', '#{url}', '#{options[:title]}')" onmouseout="addthis_close()" onclick="return addthis_sendto()">}
        s << %Q{<img src="http://s7.addthis.com/static/btn/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a>}
        addthis_tag(s, options)
      end
      alias addthis_share_button addthis_bookmark_button

      def addthis_feed_button(url, *args)
        options = extract_options(args)
        s = %Q{<a href="http://www.addthis.com/feed.php?pub=&h1=#{url}&t1=" onclick="return addthis_open(this, 'feed', '#{url}')" alt="Subscribe using any feed reader!" target="_blank">}
        s << %Q{<img src="http://s7.addthis.com/static/btn/lg-feed-en.gif" width="125" height="16" alt="Subscribe" style="border:0"/></a>}
        addthis_tag(s, options)
      end

      def addthis_email_button(*args)
        url, options = extract_url_and_options(args)
        s = %Q{<a href="http://www.addthis.com/bookmark.php" style="text-decoration:none;" onclick="return addthis_open(this, 'email', '#{url}', '#{options[:title]}');" >}
        s << %Q{<img src="http://s7.addthis.com/button1-email.gif" width="54" height="16" border="0" alt="Email" /></a>}
        addthis_tag(s, options)
      end

      protected
      def addthis_tag(str, options = {})
        s = [%Q{<!-- AddThis Button BEGIN -->}]
        s << %Q{<script type="text/javascript">var addthis_pub="";</script>} if false
        s << str
        s << %Q{<script type="text/javascript" src="http://s7.addthis.com/js/200/addthis_widget.js"></script>}
        s << %Q{<!-- AddThis Button END -->}
        s * "\n"
      end

      def extract_url_and_options(args, options = {:title => "[TITLE]"})
        url = args[0].is_a?(String) ? args.shift : "[URL]"
        return url, options = extract_options(args, options)
      end

      def extract_options(args, options = {})
        title = args[0].is_a?(String) ? args.shift : options[:title]
        options = args[0].is_a?(Hash) ? args.shift : options
        options[:title] = title
        return options
      end
    end
  end
end