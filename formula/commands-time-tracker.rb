class CommandsTimeTracker < Formula
  desc "A universal command time tracker"
  homepage "https://github.com/ThiagoEvoa/commands_time_tracker"
  url "https://github.com/ThiagoEvoa/commands_time_tracker/archive/v1.3.6.tar.gz"
  # curl -L https://github.com/ThiagoEvoa/commands_time_tracker/archive/vx.x.x.tar.gz | shasum -a 256
  sha256 "2864a27d6e067e998670d3d641c7cb5269cd39d8cd420064a16d46b30e7ef089"

  license "MIT"

  def install
    bin.install "bin/summarize.zsh" => "summarize"
    pkgshare.install "bin/time_tracker.sh"
  end

  def caveats
    <<~EOS
      To add an specific folder to track the commands, add the following line to your .zshrc:
      
        export TIME_TRACK_REPOS=("https://github.com" "git@github.com")
        
      To start tracking your commands, add the following line to your .zshrc:
      
        source #{opt_pkgshare}/time_tracker.sh
        
      To enable automatic 12-hour summaries, run this command:
      
        (crontab -l 2>/dev/null; echo "0 */12 * * * #{opt_bin}/summarize >> ~/summarizer.log 2>&1") | crontab -
      
      - To remove the automated cron job: summarize --uninstall
    EOS
  end

  test do
    assert_predicate bin/"summarize", :exist?
  end
end
