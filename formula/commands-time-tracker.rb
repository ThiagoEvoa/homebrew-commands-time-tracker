class CommandsTimeTracker < Formula
  desc "A universal command time tracker"
  homepage "https://github.com/ThiagoEvoa/commands_time_tracker"
  url "https://github.com/ThiagoEvoa/commands_time_tracker/archive/v1.1.3.tar.gz"
  sha256 "7b3032de35af95543ae695b4b0e5ec8fde3dc7b48b133d2ea23f8df2218ec74c"

  license "MIT"

  def install
    bin.install "bin/summarize.zsh" => "summarize"
    pkgshare.install "bin/time_tracker.sh"
  end

  def caveats
    <<~EOS
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
