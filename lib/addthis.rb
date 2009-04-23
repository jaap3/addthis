module Jaap3
  module Addthis
    CONFIG = {
      :publisher => ""
    }
    DEFAULT_OPTIONS = {
      :script_src => "http://s7.addthis.com/js/200/addthis_widget.js",
      :secure => false
    }
    BOOKMARK_BUTTON_DEFAULTS = {
      :title => "",
      :alt => "Bookmark and Share"
    }
    FEED_BUTTON_DEFAULTS = {
      :title => "Subscribe using any feed reader!",
      :alt => "Subscribe"
    }
    EMAIL_BUTTON_DEFAULTS = {
      :title => "",
      :alt => "Email"
    }

    module Helper
      def addthis_bookmark_button(*args)
        url, options = extract_addthis_url_and_options(args)
        options = BOOKMARK_BUTTON_DEFAULTS.merge(options)
        s = %Q{<a href="http://www.addthis.com/bookmark.php?v=20" onmouseover="}
        s << %Q{return addthis_open(this, '', '#{url}', '#{options[:page_title]}')"}
        s << %Q{ title="#{options[:title]}"}
        s << %Q{ onmouseout="addthis_close()" onclick="return addthis_sendto()">}
        s << %Q{<img src="http://s7.addthis.com/static/btn/lg-share-en.gif"}
        s << %Q{ width="125" height="16" alt="#{options[:alt]}" style="border:0"/></a>}
        addthis_tag(s, options)
      end
      alias addthis_share_button addthis_bookmark_button

      def addthis_feed_button(url, *args)
        options = FEED_BUTTON_DEFAULTS.merge(extract_addthis_options(args))
        s = %Q{<a href="http://www.addthis.com/feed.php?pub=#{options[:publisher]}&h1=#{url}&t1="}
        s << %Q{ onclick="return addthis_open(this, 'feed', '#{url}')"}
        s << %Q{ title="#{options[:title]}" target="_blank">}
        s << %Q{<img src="http://s7.addthis.com/static/btn/lg-feed-en.gif"}
        s << %Q{width="125" height="16" alt="#{options[:alt]}" style="border:0"/></a>}
        addthis_tag(s, options)
      end

      def addthis_email_button(*args)
        url, options = extract_addthis_url_and_options(args)
        options = EMAIL_BUTTON_DEFAULTS.merge(options)
        s = %Q{<a href="http://www.addthis.com/bookmark.php"}
        s << %Q{ style="text-decoration:none;" title="#{options[:title]}"}
        s << %Q{ onclick="return addthis_open(this, 'email', '#{url}', '#{options[:page_title]}');">}
        s << %Q{<img src="http://s7.addthis.com/button1-email.gif" width="54" height="16" border="0" alt="#{options[:alt]}" /></a>}
        addthis_tag(s, options)
      end

      protected
      def addthis_tag(str, options = {})
        s = [%Q{<!-- AddThis Button BEGIN -->}]
        s << %Q{<script type="text/javascript">var addthis_pub="#{options[:publisher]}";</script>}
        s << str
        s << %Q{<script type="text/javascript" src="#{options[:script_src]}"></script>}
        s << %Q{<!-- AddThis Button END -->}
        s = s * "\n"
        options[:secure] ? s.gsub(/http:\/\/s[57]\.addthis\.com/, "https://secure.addthis.com") : s
      end

      def extract_addthis_url_and_options(args, options = {:page_title => "[TITLE]"})
        url = args[0].is_a?(String) ? args.shift : "[URL]"
        return url, options = extract_addthis_options(args, options)
      end

      def extract_addthis_options(args, options = {})
        page_title = args[0].is_a?(String) ? args.shift : options[:page_title]
        options = args[0].is_a?(Hash) ? args.shift : options
        options[:page_title] = page_title
        options = CONFIG.merge(DEFAULT_OPTIONS).merge(options)
        options.symbolize_keys! if options.respond_to?(:symbolize_keys!)
        return options
      end
    end
  end
end