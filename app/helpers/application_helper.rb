module ApplicationHelper
  def default_meta_tags
    #TO DO: update before going live or once needed details are available
    # update each html page <% set_meta_tags title: 'Contact page', description: 'Contact us from...' %>

    {
      site: 'LazyShorts.dev',
      title: 'Lazy Shorts',
      reverse: true,
      separator: '|',
      description: 'Automatically generating short-form content from Reddit posts.',
      keywords: 'reddit, short-form content, video creation, auto-generated content, Reddit videos, Reddit clips, quick video generation, video marketing, content creation, social media videos, automated video tools, viral content, trending videos, video automation, Reddit video tool, content repurposing, fast video creation, short videos, video platform, free ai video generator',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'LazyShorts.dev',
        title: 'Lazy Shorts',
        description: 'Create short-form videos effortlessly from any Reddit post URL.',
        type: 'website',
        url: request.original_url,
        image: image_url('shorts-preview.png')
      }
    }

  end
end
