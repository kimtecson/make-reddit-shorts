import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="script-edit"
export default class extends Controller {
  connect() {
    console.log('script controller connected');
  }

  submit(event) {
    event.preventDefault();
    const redditPostUrl = 'https://www.reddit.com/r/relationship_advice/comments/1ek0pmb/im_a_30f_and_my_boyfriend_is_29m_weve_been/'

    fetch(`/reddit_post?url=${encodeURIComponent(redditPostUrl)}`)
      .then(response => response.json())
      .then(data => {
        console.log('Reddit post selftext:', data.selftext);
      })
      .catch(error => {
        console.error('Error fetching Reddit post:', error);
      });
  }
}
