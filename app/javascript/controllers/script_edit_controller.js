import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "script"]

  connect() {
    console.log('script controller connected');
  }

  checkUrl() {
    const inputField = this.inputTarget;
    const url = inputField.value.trim();

    if (this.isValidRedditPostUrl(url)) {
      this.fetchRedditPost(url);
    } else {
      this.scriptTarget.value = '';
    }
  }

  isValidRedditPostUrl(url) {
    const redditPostPattern = /^https?:\/\/(www\.)?reddit\.com\/r\/[\w-]+\/comments\/[\w-]+\//;
    return redditPostPattern.test(url);
  }

  fetchRedditPost(url) {
    fetch(`/reddit_post?url=${encodeURIComponent(url)}`)
      .then(response => response.json())
      .then(data => {
        this.scriptTarget.value = data.selftext || 'No content available';
      })
      .catch(error => {
        console.error('Error fetching Reddit post:', error);
        this.scriptTarget.value = 'Error fetching Reddit post';
      });
  }
}
