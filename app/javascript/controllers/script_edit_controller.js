import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "script", "estimate"]

  connect() {
    console.log('script controller connected');
    this.checkUrl();
  }

  checkUrl() {
    const inputField = this.inputTarget;
    const url = inputField.value.trim();

    if (this.isValidRedditPostUrl(url)) {
      this.fetchRedditPost(url);
    } else {
      this.scriptTarget.value = '';
      this.updateEstimate();
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
        this.updateEstimate();
      })
      .catch(error => {
        console.error('Error fetching Reddit post:', error);
        this.scriptTarget.value = 'Error fetching Reddit post';
        this.updateEstimate();
      });
  }

  updateEstimate() {
    const text = this.scriptTarget.value;
    const wordCount = text.trim().split(/\s+/).length;
    const speechTimeInSeconds = Math.round(wordCount / (200 / 60));  // 135 words per minute

    let estimateText;
    if (speechTimeInSeconds < 60) {
      estimateText = `${speechTimeInSeconds} second${speechTimeInSeconds !== 1 ? 's' : ''}`;
    } else {
      const minutes = Math.floor(speechTimeInSeconds / 60);
      const seconds = speechTimeInSeconds % 60;
      estimateText = `${minutes} minute${minutes !== 1 ? 's' : ''} and ${seconds} second${seconds !== 1 ? 's' : ''}`;
    }

    this.estimateTarget.textContent = `Estimated speech time: ${estimateText}`;
  }
}
