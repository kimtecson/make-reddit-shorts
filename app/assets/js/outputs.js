document.addEventListener("DOMContentLoaded", function() {
    const outputId = document.querySelector("[data-output-id]").dataset.outputId;
    let lastProgress = 0;
  
    function checkIfVideoExists() {
      const videoElement = document.getElementById("video-element");
      if (videoElement) {
        document.getElementById("progress-bar-container").style.display = "none";
        return true;
      }
      return false;
    }
  
    const progressMessages = {
      0: "Getting Reddit post URL",
      20: "Generating voice over",
      35: "Transcribing voice over",
      50: "Creating title image",
      60: "Putting everything together",
      64: "Well at least trying to",
      67: "Trying is what matters",
      69: "Right?",
      73: "This might take a while",
      77: "Kidding! It's almost done",
    };
  
    function getProgressMessage(progress) {
      let message = "Processing";
      let percentageMessage = `(${progress}%)`;
      Object.keys(progressMessages).forEach(key => {
        if (progress >= key) {
          message = `${progressMessages[key]} ${percentageMessage}`;
        }
      });
      return message;
    }
  
    function checkProgress() {
      if (checkIfVideoExists()) return;
  
      fetch(`/outputs/${outputId}/progress`)
        .then(response => response.json())
        .then(data => {
          const progress = data.progress;
          const progressBarElem = document.getElementById("progress-bar");
          const messageElem = document.querySelector(".hello-world");
  
          if (progress > lastProgress) {
            const increment = Math.ceil((progress - lastProgress) / 20);
            function updateProgress(currentProgress) {
              if (currentProgress <= progress) {
                progressBarElem.style.width = currentProgress + "%";
                messageElem.innerText = getProgressMessage(currentProgress);
                setTimeout(() => updateProgress(currentProgress + increment), 50);
              } else {
                lastProgress = progress;
                if (progress >= 100) {
                  document.getElementById("progress-bar-container").style.display = "none";
                  fetch(`/outputs/${outputId}/video_url`)
                    .then(response => response.json())
                    .then(data => {
                      document.getElementById("video-container").innerHTML = `<video src="${data.url}" width="160" height="120" controls></video>`;
                    });
                } else {
                  setTimeout(checkProgress, 1000);
                }
              }
            }
            updateProgress(lastProgress + increment);
          }
        });
    }
    checkProgress();
  });
  